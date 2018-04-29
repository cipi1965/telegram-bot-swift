// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation


/// Represents a venue. By default, the venue will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the venue.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#inlinequeryresultvenue>

public struct InlineQueryResultVenue: JsonConvertible, InternalJsonConvertible {
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

    /// Type of the result, must be venue
    public var typeString: String {
        get { return internalJson["type"].stringValue }
        set { internalJson["type"].stringValue = newValue }
    }

    /// Unique identifier for this result, 1-64 Bytes
    public var id: String {
        get { return internalJson["id"].stringValue }
        set { internalJson["id"].stringValue = newValue }
    }

    /// Latitude of the venue location in degrees
    public var latitude: Float {
        get { return internalJson["latitude"].floatValue }
        set { internalJson["latitude"].floatValue = newValue }
    }

    /// Longitude of the venue location in degrees
    public var longitude: Float {
        get { return internalJson["longitude"].floatValue }
        set { internalJson["longitude"].floatValue = newValue }
    }

    /// Title of the venue
    public var title: String {
        get { return internalJson["title"].stringValue }
        set { internalJson["title"].stringValue = newValue }
    }

    /// Address of the venue
    public var address: String {
        get { return internalJson["address"].stringValue }
        set { internalJson["address"].stringValue = newValue }
    }

    /// Optional. Foursquare identifier of the venue if known
    public var foursquareId: String? {
        get { return internalJson["foursquare_id"].string }
        set { internalJson["foursquare_id"].string = newValue }
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

    /// Optional. Content of the message to be sent instead of the venue
    public var inputMessageContent: InputMessageContent? {
        get {
            fatalError("Not implemented")
        }
        set {
            internalJson["input_message_content"] = JSON(newValue?.json ?? JSON.null)
        }
    }

    /// Optional. Url of the thumbnail for the result
    public var thumbUrl: String? {
        get { return internalJson["thumb_url"].string }
        set { internalJson["thumb_url"].string = newValue }
    }

    /// Optional. Thumbnail width
    public var thumbWidth: Int? {
        get { return internalJson["thumb_width"].int }
        set { internalJson["thumb_width"].int = newValue }
    }

    /// Optional. Thumbnail height
    public var thumbHeight: Int? {
        get { return internalJson["thumb_height"].int }
        set { internalJson["thumb_height"].int = newValue }
    }

    internal init(json: JSON = [:]) {
        self.internalJson = json
    }
    public init(jsonObject: Any) {
        self.internalJson = JSON(jsonObject)
    }
}
