//
//  AuthView.swift
//  BidRoom
//
//  Created by Zachary Legzdin on 11/17/26.
//

import SwiftUI
 
// The login / create-account screen.
struct AuthView: View {
    @ObservedObject var vm: AuthViewModel
 
    var body: some View {
        VStack(spacing: 16) {
            Text("BidRoom")
                .font(.largeTitle.bold())
 
            TextField("Email", text: $vm.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
 
            SecureField("Password", text: $vm.password)
                .textFieldStyle(.roundedBorder)
 
            if let message = vm.message {
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }
 
            Button("Log in") {
                Task { await vm.signIn() }
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isLoading)
 
            Button("Create account") {
                Task { await vm.signUp() }
            }
            .disabled(vm.isLoading)
        }
        .padding()
    }
}
 
