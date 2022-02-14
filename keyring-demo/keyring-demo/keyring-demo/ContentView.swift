//
//  ContentView.swift
//  keyring-tester
//
//  Created by Daniel Brotsky on 12/5/21.
//

import SwiftUI

struct ContentView: View {
    @State var service = "service1"
    @State var account = "account1"
    @State var passwordIn = "password1"
    @State var passwordOut = ""
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    enum Field: Hashable {
        case service
        case account
        case passwordIn
    }
    
    @FocusState var focusedField: Field?
    
    var body: some View {
        Form {
            Section("Service Name") {
                TextField("Service Name", text: $service)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .service)
            }
            Section("Account Name") {
                TextField("Account Name", text: $account)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .account)
            }
            Section("Set or Update Password") {
                TextField("Password to Set", text: $passwordIn)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .passwordIn)
                Button("Set Password") {
                    if is_input_valid() {
                        add_or_update_password()
                    }
                }
            }
            Section("Get or Delete Password") {
                Button("Get Password") {
                    if is_input_valid() {
                        get_password()
                    }
                }
                Text(passwordOut)
                Button("Delete Password") {
                    if is_input_valid() {
                        delete_password()
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("\(alertTitle)"),
                  message: Text("\(alertMessage)"))
        }
    }
    
    func is_input_valid() -> Bool {
        guard service.isEmpty || account.isEmpty else {
            focusedField = nil
            return true
        }
        if service.isEmpty {
            focusedField = .service
        } else if account.isEmpty {
            focusedField = .account
        }
        showAlert = true
        alertTitle = "Failure"
        alertMessage = "You must specify both a service name and a user name"
        return false
    }
    
    func add_or_update_password() {
        showAlert = true
        guard !passwordIn.isEmpty else {
            focusedField = .passwordIn
            alertTitle = "Failure"
            alertMessage = "Can't set empty password; use Delete Password instead."
            return
        }
        do {
            try PasswordOps.setPassword(service: service, user: account, password: passwordIn)
            passwordOut = ""
            alertTitle = "Success"
            alertMessage = "Password set!"
        } catch PasswordError.unexpected(let status) {
            alertTitle = "Failure"
            alertMessage = "Set Password failed: OSStatus \(status)"
        } catch {
            alertTitle = "Failure"
            alertMessage = "Set Password failed unexpectedly: \(error)"
        }
    }
    
    func get_password() {
        do {
            try passwordOut = PasswordOps.getPassword(service: service, user: account)
        } catch {
            passwordOut = ""
            showAlert = true
            alertTitle = "Failure"
            switch error {
            case PasswordError.notFound:
                alertMessage = "No keychain entry found for service '\(service)' and account '\(account)'"
            case PasswordError.notString(let data):
                var password = ""
                _ = transcode(data.makeIterator(), from: UTF8.self, to: UTF8.self, stoppingOnError: false, into: {
                    password.append(contentsOf: String(Unicode.Scalar($0)))
                })
                passwordOut = password
                alertMessage = "Password is not UTF-8 encoded, bytes have been replaced"
            case PasswordError.unexpected(let status):
                alertMessage = "Get Password failed: OSStatus \(status)"
            default:
                alertMessage = "Get Password failed: \(error)"
            }
        }
    }
    
    func delete_password() {
        do {
            try PasswordOps.deletePassword(service: service, user: account)
            passwordOut = ""
        } catch {
            showAlert = true
            alertTitle = "Failure"
            switch error {
            case PasswordError.notFound:
                passwordOut = ""
                alertMessage = "No keychain entry found for service '\(service)' and account '\(account)'"
            case PasswordError.unexpected(let status):
                alertMessage = "Delete Password failed: OSStatus \(status)"
            default:
                alertMessage = "Delete Password failed: \(error)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
