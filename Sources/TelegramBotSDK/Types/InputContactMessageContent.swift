// Telegram Bot SDK for Swift (unofficial).
// This file is autogenerated by API/generate_wrappers.rb script.

import Foundation


/// Represents the content of a contact message to be sent as the result of an inline query.
///
/// - SeeAlso: <https://core.telegram.org/bots/api#inputcontactmessagecontent>

public struct InputContactMessageContent: JsonConvertible, InternalJsonConvertible {
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

    /// Contact's phone number
    public var phoneNumber: String {
        get { return internalJson["phone_number"].stringValue }
        set { internalJson["phone_number"].stringValue = newValue }
    }

    /// Contact's first name
    public var firstName: String {
        get { return internalJson["first_name"].stringValue }
        set { internalJson["first_name"].stringValue = newValue }
    }

    /// Optional. Contact's last name
    public var lastName: String? {
        get { return internalJson["last_name"].string }
        set { internalJson["last_name"].string = newValue }
    }

    internal init(json: JSON = [:]) {
        self.internalJson = json
    }
    public init(jsonObject: Any) {
        self.internalJson = JSON(jsonObject)
    }
}
