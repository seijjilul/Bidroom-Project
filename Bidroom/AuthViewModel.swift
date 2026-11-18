//
//  AuthViewModel.swift
//  BidRoom
//
//  Created by Zachary Legzdin on 11/17/26.
//

import Foundation
import Supabase
public import Combine

// Holds the login state and does the sign-up / log-in / log-out work.
@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignedIn = false
    @Published var currentEmail: String?
    @Published var isLoading = false
    @Published var message: String?

    // Called when the app opens, to see if someone is already logged in.
    func checkSession() async {
        do {
            let session = try await supabase.auth.session
            currentEmail = session.user.email
            isSignedIn = true
        } catch {
            isSignedIn = false
        }
    }

    func signUp() async {
        isLoading = true
        message = nil
        defer { isLoading = false }
        do {
            let response = try await supabase.auth.signUp(email: email, password: password)
            if let session = response.session {
                currentEmail = session.user.email
                isSignedIn = true
            } else {
                // Happens when "Confirm email" is turned on in Supabase.
                message = "Check your email to confirm your account, then log in."
            }
        } catch {
            message = error.localizedDescription
        }
    }

    func signIn() async {
        isLoading = true
        message = nil
        defer { isLoading = false }
        do {
            let session = try await supabase.auth.signIn(email: email, password: password)
            currentEmail = session.user.email
            isSignedIn = true
        } catch {
            message = error.localizedDescription
        }
    }

    func signOut() async {
        do {
            try await supabase.auth.signOut()
            isSignedIn = false
            currentEmail = nil
            password = ""
        } catch {
            message = error.localizedDescription
        }
    }
}
