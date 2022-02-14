//
//  ios_test_harnessTests.swift
//  ios-test-harnessTests
//
//  Created by Daniel Brotsky on 1/29/22.
//

import XCTest
@testable import iOS_Test_Harness

class ios_test_harnessTests: XCTestCase {

    func testRun() throws {
        TestRunner.runTest()
    }

}
