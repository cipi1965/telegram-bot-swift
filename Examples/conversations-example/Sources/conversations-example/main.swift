import Foundation
import TelegramBotSDK

let token = readToken(from: "CONVERSATIONS_BOT_TOKEN")

let bot = TelegramBot(token: token)

let router = Router(bot: bot)
router.addConversation(TestConversation.self)
router.add(Command("start")) { (context) -> Bool in
    _ = context.startConversation("test")
    return true
}
router.unmatched = { (context) in
    return false
}

print("Ready to accept commands")
while let update = bot.nextUpdateSync() {
    try router.process(update: update)
}

fatalError("Server stopped due to error: \(bot.lastError.unwrapOptional)")
