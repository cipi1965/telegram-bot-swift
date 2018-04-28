//
// MessageOrBool.swift
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


public enum MessageOrBool: JsonConvertible, InternalJsonConvertible {
    case message(Message)
    case bool(Bool)
    
    public init(json: JSON) {
        if nil != json.bool {
            self = .bool(Bool(json: json))
        } else {
            self = .message(Message(json: json))
        }
    }

    public var json: Any {
        get {
            return internalJson.object
        }
        set {
            internalJson = JSON(newValue)
        }
    }
    
    internal var internalJson: JSON {
        get {
            switch self {
            case .message(let message): return message.internalJson
            case .bool(let bool): return bool.internalJson
            }
        }
        set {
            self = MessageOrBool(json: internalJson)
        }
    }
}
