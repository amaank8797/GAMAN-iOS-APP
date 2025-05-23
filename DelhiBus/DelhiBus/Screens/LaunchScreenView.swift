//
//  LaunchScreenView.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//


import SwiftUI

struct LaunchScreenView: View {
    @State private var showLogo = false
    @State private var showText = false
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Logo with animation
                Image("logobgfree")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .offset(y: showLogo ? 80 : -UIScreen.main.bounds.height) // Start above the screen
                    .scaleEffect(showLogo ? 2 : 0.5)  
                    .animation(
                        .spring(response: 0.8, dampingFraction: 0.6, blendDuration: 1)
                            .delay(0.3),
                        value: showLogo
                    )
                
                Spacer()
                
                VStack(spacing: 10) {
                    // Full form text
                    Text("Gaman")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .multilineTextAlignment(.center)
                    
                    // Slogan text
                    Text("Never Miss a Bus Again!")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                }
                .offset(y: showText ? 0 : UIScreen.main.bounds.height) // Start below the screen
                .animation(
                    .easeInOut(duration: 0.8)
                        .delay(0.5),
                    value: showText
                )
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            showLogo = true
            showText = true
        }
    }
}

#Preview {
    LaunchScreenView()
}
