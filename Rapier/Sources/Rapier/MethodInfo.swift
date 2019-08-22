import Foundation

public struct MethodInfo {
    public init(parameters: [String: FieldInfo] = [:], result: FieldInfo, documentation: String?) {
        self.parameters = parameters
        self.result = result
        self.documentation = documentation
    }
    
    public var parameters: [String: FieldInfo]
    public var result: FieldInfo
    public var documentation: String?
}
