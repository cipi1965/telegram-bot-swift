//
// Conversation.swift
//
// This source file is part of the Telegram Bot SDK for Swift (unofficial).
//
// Copyright (c) 2015 - 2020 Andrey Fidrya and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of the project authors
//


import Foundation

public protocol Conversation {
    static var name: String { get }
    
    var bot: TelegramBot? { get set }
    var chatId: Int64? { get set }
    var router: Router? { get set }
    
    init()
    init(chatId: Int64, bot: TelegramBot, router: Router)
    
    func start()
    
    func handleUpdate(update: Update, properties: [String: AnyObject])
    
    func end()
}

public extension Conversation {
    init(chatId: Int64, bot: TelegramBot, router: Router) {
        self.init()
        self.chatId = chatId
        self.bot = bot
        self.router = router
    }
    
    func end() {
        guard let chatId = chatId else { return }
        router?.endConversationForChatId(chatId)
    }
}
