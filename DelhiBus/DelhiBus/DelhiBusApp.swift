//
//  DelhiBusApp.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 18/02/25.
//

import SwiftUI
import Firebase

@main
struct DelhiBusApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @State private var showSplash = true
    @State private var showLaunchScreen = false

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashIcon()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Splash duration
                            showSplash = false
                            showLaunchScreen = true
                        }
                    }
            } else if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Launch screen duration
                            showLaunchScreen = false
                        }
                    }
            } else {
                ContentView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

