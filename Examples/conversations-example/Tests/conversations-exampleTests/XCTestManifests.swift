import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(conversations_exampleTests.allTests),
    ]
}
#endif
