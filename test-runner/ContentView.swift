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

let testOps = [
	TestChoice(id: 0, description: "Create entry with no user presence required"),
	TestChoice(id: 1, description: "Create entry with user presence required"),
	TestChoice(id: 2, description: "Set an existing entry"),
	TestChoice(id: 3, description: "Read an existing entry"),
	TestChoice(id: 4, description: "Delete an existing entry"),
];

struct ContentView: View {
    @State var showAlert = false;
	@State var testOpIndex: Int32 = 0;

    var body: some View {
		Picker("Choose operation", selection: $testOpIndex) {
			ForEach(testOps) {
				Text($0.description).tag($0.id)
			}
		}
        Button("Run Test") {
            TestRunner.runTest(testOpIndex)
            showAlert = true
		}.padding(10)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Test Result"),
                  message: Text("No crash! See the log for details."))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
