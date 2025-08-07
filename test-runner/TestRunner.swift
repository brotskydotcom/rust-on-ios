//
// TestRunner.swift
// static-test-harness
//

import Foundation

class TestRunner {
	static func runTest(_ op: Int32) {
        test(op)
    }

	static func getTestChoices() -> String {
		return String(cString: choices())
	}
}
