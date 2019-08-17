//
// TelegramBot.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2016 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//

import Foundation
import Dispatch
import TelegramBotSDKRequestProvider
import TelegramBotSDKCurl

import CCurl

public class TelegramBot {

	public typealias RequestParameters = [String: Any?]
	
    /// Telegram server URL.
    public var url = "https://api.telegram.org"
    
    /// Unique authentication token obtained from BotFather.
    public var token: String
	
	/// Default request parameters
	public var defaultParameters = [String: RequestParameters]()
	
    /// In case of network errors or server problems,
    /// do not report the errors and try to reconnect
    /// automatically.
    public var autoReconnect: Bool = true

    /// Offset for long polling.
    public var nextOffset: Int64?

    /// Number of updates to fetch by default.
    public var defaultUpdatesLimit: Int = 100

    /// Default getUpdates timeout in seconds.
    public var defaultUpdatesTimeout: Int = 60
    
    // Should probably be a LinkedList, but it won't be longer than
    // 100 elements anyway.
    var unprocessedUpdates: [Update]
    
    /// Queue for callbacks in asynchronous versions of requests.
    public var queue = DispatchQueue.main
    
    /// Last error for use with synchronous requests.
    public var lastError: RequestError?
    
    /// Logging function. Defaults to `print`.
    public var logger: (_ text: String) -> () = { print($0) }
    
    /// Request wrapper. Defaults to Curl for now
    public var requestWrapper: RequestProvider.Type = CurlRequestProvider.self
    
    /// Defines reconnect delay in seconds when requesting updates. Can be overridden.
    ///
    /// - Parameter retryCount: Number of reconnect retries associated with `request`.
    /// - Returns: Seconds to wait before next reconnect attempt. Return `0.0` for instant reconnect.
    public var reconnectDelay: (_ retryCount: Int) -> Double = { retryCount in
        switch retryCount {
        case 0: return 0.0
        case 1: return 1.0
        case 2: return 2.0
        case 3: return 5.0
        case 4: return 10.0
        case 5: return 20.0
        default: break
        }
        return 30.0
    }
    
    /// Equivalent of calling `getMe()`
    ///
    /// This function will block until the request is finished.
    public lazy var user: User = {
        guard let me = self.getMeSync() else {
            print("Unable to fetch bot information: \(self.lastError.unwrapOptional)")
            exit(1)
        }
        return me
    }()
    
    /// Equivalent of calling `user.username` and unwrapping it
    ///
    /// This function will block until the request is finished.
    public lazy var username: String = {
        guard let username = self.user.username else {
            fatalError("Unable to fetch bot username")
        }
        return username
    }()
    
    /// Equivalent of calling `BotName(username: username)`
    ///
    /// This function will block until the request is finished.
    public lazy var name: BotName = BotName(username: self.username)
    
    /// Creates an instance of Telegram Bot.
    /// - Parameter token: A unique authentication token.
    /// - Parameter fetchBotInfo: If true, issue a blocking `getMe()` call and cache the bot information. Otherwise it will be lazy-loaded when needed. Defaults to true.
    /// - Parameter session: `NSURLSession` instance, a session with `ephemeralSessionConfiguration` is used by default.
    public init(token: String, fetchBotInfo: Bool = true) {
        self.token = token
        self.unprocessedUpdates = []
        if fetchBotInfo {
            _ = user // Load the lazy user variable
        }
    }
    
    deinit {
        //print("Deinit")
    }
    
    /// Returns next update for this bot.
    ///
    /// Blocks while fetching updates from the server.
    ///
	/// - Parameter mineOnly: Ignore commands not addressed to me, i.e. `/command@another_bot`.
    /// - Returns: `Update`. `Nil` on error, in which case details
    ///   can be obtained from `lastError` property.
	public func nextUpdateSync(onlyMine: Bool = true) -> Update? {
        while let update = nextUpdateSync() {
			if onlyMine {
	            if let message = update.message, !message.addressed(to: self) {
					continue
				}
			}
			
            return update
        }
        return nil
    }
    
    /// Waits for specified number of seconds. Message loop won't be blocked.
    ///
    /// - Parameter wait: Seconds to wait.
    public func wait(seconds: Double) {
        let sem = DispatchSemaphore(value: 0)
        DispatchQueue.global().asyncAfter(deadline: .now() + seconds) {
            sem.signal()
        }
        RunLoop.current.waitForSemaphore(sem)
    }
    
    /// Initiates a request to the server. Used for implementing
    /// specific requests (getMe, getStatus etc).
    internal func startDataTaskForEndpoint(_ endpoint: String, completion: @escaping RequestCompletion) {
        startDataTaskForEndpoint(endpoint, parameters: [:], completion: completion)
    }
    
    /// Initiates a request to the server. Used for implementing
    /// specific requests.
    internal func startDataTaskForEndpoint(_ endpoint: String, parameters: [String: Any?], completion: @escaping RequestCompletion) {
        let endpointUrl = urlForEndpoint(endpoint)
        
        // If parameters contain values of type InputFile, use  multipart/form-data for sending them.
        var hasAttachments = false
        for value in parameters.values {
            if value is InputFile {
                hasAttachments = true
                break
            }
            
            if value is InputFileOrString {
                if case let InputFileOrString.inputFile(_) = (value as! InputFileOrString) {
                    hasAttachments = true
                    break
                }
            }
        }

        let contentType: String
        var requestDataOrNil: Data?
        if hasAttachments {
            let boundary = HTTPUtils.generateBoundaryString()
            contentType = "multipart/form-data; boundary=\(boundary)"
            requestDataOrNil = HTTPUtils.createMultipartFormDataBody(with: parameters, boundary: boundary)
            //try! requestDataOrNil!.write(to: URL(fileURLWithPath: "/tmp/dump.bin"))
            logger("endpoint: \(endpoint), sending parameters as multipart/form-data")
        } else {
            contentType = "application/x-www-form-urlencoded"
            let encoded = HTTPUtils.formUrlencode(parameters)
            requestDataOrNil = encoded.data(using: .utf8)
            logger("endpoint: \(endpoint), data: \(encoded)")
        }
        
        guard let requestData = requestDataOrNil else {
            completion(nil, nil)
            return
        }
        
        requestWrapper.doRequest(endpointUrl: endpointUrl, contentType: contentType, requestData: requestData, completion: completion)
    }
    
    private func urlForEndpoint(_ endpoint: String) -> URL {
        let tokenUrlencoded = token.urlQueryEncode()
        let endpointUrlencoded = endpoint.urlQueryEncode()
        let urlString = "\(url)/bot\(tokenUrlencoded)/\(endpointUrlencoded)"
        guard let result = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        return result
    }
}
