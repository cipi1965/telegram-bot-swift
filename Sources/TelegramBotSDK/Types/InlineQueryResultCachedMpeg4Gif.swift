// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation


/// Represents a link to a video animation (H.264/MPEG-4 AVC video without sound) stored on the Telegram servers. By default, this animated MPEG-4 file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinequeryresultcachedmpeg4gif>

public struct InlineQueryResultCachedMpeg4Gif: JsonConvertible, InternalJsonConvertible {
    /// Original JSON for fields not yet added to Swift structures.
    public var json: Any {
        get {
            return internalJson.object
        }
        set {
            internalJson = JSON(newValue)
        }
    }
    internal var internalJson: JSON

    /// Type of the result, must be mpeg4_gif
    public var typeString: String {
        get { return internalJson["type"].stringValue }
        set { internalJson["type"].stringValue = newValue }
    }

    /// Unique identifier for this result, 1-64 bytes
    public var id: String {
        get { return internalJson["id"].stringValue }
        set { internalJson["id"].stringValue = newValue }
    }

    /// A valid file identifier for the MP4 file
    public var mpeg4FileId: String {
        get { return internalJson["mpeg4_file_id"].stringValue }
        set { internalJson["mpeg4_file_id"].stringValue = newValue }
    }

    /// Optional. Title for the result
    public var title: String? {
        get { return internalJson["title"].string }
        set { internalJson["title"].string = newValue }
    }

    /// Optional. Caption of the MPEG-4 file to be sent, 0-200 characters
    public var caption: String? {
        get { return internalJson["caption"].string }
        set { internalJson["caption"].string = newValue }
    }

    /// Optional. Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in the media caption.
    public var parseModeString: String? {
        get { return internalJson["parse_mode"].string }
        set { internalJson["parse_mode"].string = newValue }
    }

    /// Optional. Inline keyboard attached to the message
    public var replyMarkup: InlineKeyboardMarkup? {
        get {
            let value = internalJson["reply_markup"]
            return value.isNullOrUnknown ? nil : InlineKeyboardMarkup(json: value)
        }
        set {
            internalJson["reply_markup"] = newValue?.internalJson ?? JSON.null
        }
    }

    /// Optional. Content of the message to be sent instead of the video animation
    public var inputMessageContent: InputMessageContent? {
        get {
            fatalError("Not implemented")
        }
        set {
            internalJson["input_message_content"] = JSON(newValue?.json ?? JSON.null)
        }
    }

    internal init(json: JSON = [:]) {
        self.internalJson = JSON(json)
    }
}
