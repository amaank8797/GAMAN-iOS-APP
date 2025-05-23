//
//  SplashIcon.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//

import SwiftUI

struct SplashIcon: View {
    @State var show = false
    @State var show2 = false
    @State var scale: CGFloat = 1
    @State private var isActive = false // Tracks if animation is complete

    var body: some View {
        ZStack {
            if isActive {
                // Navigate to the Main App
                ContentView()
            } else {
                ZStack {
                    Color.white.ignoresSafeArea() // Background color
                    
                   
                        .mask {
                            Image(systemName: "bus")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .foregroundStyle(.yellow)
                                .scaleEffect(scale)
                                .contentTransition(.opacity)
                        }
                    
                    // MARK: - Foreground Image Animation
                    Image(systemName: "bus")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(.yellow)
                        .scaleEffect(show ? 0 : 1)
                        .scaleEffect(scale)
                        .opacity(show ? 0 : 1)
                }
                .onAppear {
                    // MARK: - Animation Sequence
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.spring) {
                            show2.toggle()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.spring(duration: 1)) {
                            show.toggle()
                            scale = 30
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashIcon()
}
