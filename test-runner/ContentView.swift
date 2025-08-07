//
//  ContentView.swift
//  static-test-harness
//
//  Created by Daniel Brotsky on 1/29/22.
//

import SwiftUI

struct TestChoice: Identifiable {
	let id: Int32
	let description: String
}

func createTestOps() -> [TestChoice] {
	let choiceString = TestRunner.getTestChoices()
	let choices = choiceString.split(separator: "\n", omittingEmptySubsequences: true)
	var result: [TestChoice] = []
	for i in 0..<choices.count {
		let choice = String(choices[i]).trimmingCharacters(in: .whitespaces)
		if choice.isEmpty { continue }
		result.append(TestChoice(id: Int32(i), description: String(choices[i]).trimmingCharacters(in: .whitespaces)))
	}
	return result
}

struct ContentView: View {
	@State var testOpIndex: Int32 = 0
	@State var testInProgress: Bool = false

	let testOps = createTestOps()

    var body: some View {
		Picker("Choose operation", selection: $testOpIndex) {
			ForEach(testOps) {
				Text($0.description).tag($0.id)
			}
		}.padding(10)
		if testInProgress {
			ProgressView("Test in progress...").padding(10)
		} else {
			Button("Run Test") {
				runTest()
			}.padding(10)
		}
    }

	func runTest() {
		testInProgress = true
		let task = DispatchWorkItem {
			TestRunner.runTest(self.testOpIndex)
			self.testInProgress = false
		}
		task.perform()
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
