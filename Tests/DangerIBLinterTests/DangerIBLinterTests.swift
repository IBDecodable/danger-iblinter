import XCTest
@testable import DangerIBLinter

final class DangerIBLinterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DangerIBLinter().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
