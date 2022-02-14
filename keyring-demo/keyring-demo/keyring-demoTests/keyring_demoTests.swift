//
//  keyring_demoTests.swift
//  keyring-demoTests
//

import XCTest
@testable import keyring_demo

class keyring_testerTests: XCTestCase {

    func testRoundtripAndUpdate() throws {
        let name: String = "testRoundtripAndUpdate"
        let password0: String = "testPassword0"
        XCTAssertNotNil(try? PasswordOps.setPassword(service: name, user: name, password: password0))
        let result0: String = try! PasswordOps.getPassword(service: name, user: name)
        XCTAssertEqual(password0, result0)
        let password1: String = "testPassword1"
        XCTAssertNotNil(try? PasswordOps.setPassword(service: name, user: name, password: password1))
        let result1: String = try! PasswordOps.getPassword(service: name, user: name)
        XCTAssertEqual(password1, result1)
        XCTAssertNotNil(try? PasswordOps.deletePassword(service: name, user: name))
    }
    
    func testMissing() throws {
        XCTAssertNil(try? PasswordOps.getPassword(service: "testMissing", user: "testMissing"))
    }

}
