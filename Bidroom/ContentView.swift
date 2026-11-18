import SwiftUI

// The first screen. Shows the login screen, or a signed-in message once logged in.
struct ContentView: View {
    @StateObject private var vm = AuthViewModel()

    var body: some View {
        Group {
            if vm.isSignedIn {
                VStack(spacing: 16) {
                    Text("Signed in as \(vm.currentEmail ?? "unknown")")
                    Button("Log out") {
                        Task { await vm.signOut() }
                    }
                }
            } else {
                AuthView(vm: vm)
            }
        }
        .task { await vm.checkSession() }
    }
}

#Preview {
    ContentView()
}
