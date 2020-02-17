//
//  File.swift
//  
//
//  Created by Matteo Piccina on 15/02/2020.
//

import Foundation
import TelegramBotSDK

class TestConversation: Conversation {
    var bot: TelegramBot?
    var chatId: Int64?
    var router: Router?
    
    var firstName: String? = nil
    var lastName: String? = nil
    
    required init() {}
    
    func start() {
        guard let chatId = chatId else { return }
        bot?.sendMessageSync(chatId: .chat(chatId), text: "Hello from conversation!")
        bot?.sendMessageSync(chatId: .chat(chatId), text: "What's your first name?")
    }
    
    func handleUpdate(update: Update, properties: [String : AnyObject]) {
        guard let chatId = chatId else { return }
        guard let messageText = update.message?.text else { return }
        if (firstName == nil) {
            firstName = messageText
            bot?.sendMessageSync(chatId: .chat(chatId), text: "Thank you! What's your last name?")
        } else if (lastName == nil) {
            lastName = messageText
            bot?.sendMessageSync(chatId: .chat(chatId), text: "Complete name: \(firstName ?? "") \(lastName ?? "")")
            bot?.sendMessageSync(chatId: .chat(chatId), text: "Thank you! Conversation will end...")
            end()
        }
    }
    
    static var name: String {
        "test"
    }
}
