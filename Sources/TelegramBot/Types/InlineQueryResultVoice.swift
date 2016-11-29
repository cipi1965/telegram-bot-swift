// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation
import SwiftyJSON

/// Represents a link to a voice recording in an .ogg container encoded with OPUS. By default, this voice recording will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the the voice message.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinequeryresultvoice>

public struct InlineQueryResultVoice: JsonConvertible {
    /// Original JSON for fields not yet added to Swift structures.
    public var json: JSON

    /// Type of the result, must be voice
    public var type_string: String {
        get { return json["type"].stringValue }
        set { json["type"].stringValue = newValue }
    }

    /// Unique identifier for this result, 1-64 bytes
    public var id: String {
        get { return json["id"].stringValue }
        set { json["id"].stringValue = newValue }
    }

    /// A valid URL for the voice recording
    public var voice_url: String {
        get { return json["voice_url"].stringValue }
        set { json["voice_url"].stringValue = newValue }
    }

    /// Recording title
    public var title: String {
        get { return json["title"].stringValue }
        set { json["title"].stringValue = newValue }
    }

    /// Optional. Caption, 0-200 characters
    public var caption: String? {
        get { return json["caption"].string }
        set { json["caption"].string = newValue }
    }

    /// Optional. Recording duration in seconds
    public var voice_duration: Int? {
        get { return json["voice_duration"].int }
        set { json["voice_duration"].int = newValue }
    }

    /// Optional. Inline keyboard attached to the message
    public var reply_markup: InlineKeyboardMarkup? {
        get {
            let value = json["reply_markup"]
            return value.isNullOrUnknown ? nil : InlineKeyboardMarkup(json: value)
        }
        set {
            json["reply_markup"] = newValue?.json ?? nil
        }
    }

    /// Optional. Content of the message to be sent instead of the voice recording
    public var input_message_content: InputMessageContent? {
        get {
            let value = json["input_message_content"]
            return value.isNullOrUnknown ? nil : InputMessageContent(json: value)
        }
        set {
            json["input_message_content"] = newValue?.json ?? nil
        }
    }

    public init(json: JSON = [:]) {
        self.json = json
    }
}
