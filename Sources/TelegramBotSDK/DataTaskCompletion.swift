//
//  DataTaskCompletion.swift
//  TelegramBotSDK
//
//  Created by Matteo Piccina on 18/04/2019.
//

import Foundation
import TelegramBotSDKRequestProvider

internal typealias DataTaskCompletion = (_ json: JSON, _ error: RequestError?)->()
