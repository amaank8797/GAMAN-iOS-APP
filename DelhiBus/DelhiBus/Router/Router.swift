//
//  Router.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//


import SwiftUI

final class Router: ObservableObject {
    @Published var navPath = NavigationPath()
    
    enum AuthFlow: Hashable, Codable {
        case login
        case createAccount
        case profile
        case forgotPassword
        case emailSent
    }
    
    func navigate(to destination: AuthFlow) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        if !navPath.isEmpty {
            navPath.removeLast()
        }
    }
    
    func navigateToRoot() {
        navPath = NavigationPath()
    }
}

