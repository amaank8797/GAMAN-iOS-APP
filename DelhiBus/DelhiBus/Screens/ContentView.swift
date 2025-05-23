//
//  ContentView.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 19/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel() // Manage authentication state
    @StateObject var router = Router() // Manage navigation
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            Group {
                if authViewModel.userSession == nil {
                    LoginView() // Show login if not authenticated
                } else {
                    MainTabView() // Show main app if authenticated
                }
            }
            .navigationDestination(for: Router.AuthFlow.self) { destination in
                switch destination {
                case .login:
                    LoginView()
                case .createAccount:
                    CreateAccountView()
                case .profile:
                    ProfileView()
                case .forgotPassword:
                    ForgotPasswordView()
                case .emailSent:
                    EmailSentView()
                }
            }
        }
        .environmentObject(authViewModel) // Provide authentication model
        .environmentObject(router) // Provide navigation router
    }
}
