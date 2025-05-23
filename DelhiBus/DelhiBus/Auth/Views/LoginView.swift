//
//  LoginView.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//



import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // logo
                logo
                // title
                titleView
                
                Spacer().frame(height: 12)
                
                // textfields
                InputView(
                    placeholder: "Email ",
                    text: $email
                )
                
                InputView(
                    placeholder: "Password",
                    isSecureField: true,
                    text: $password
                )
                // forgot button
                forgotButton
                
                // login button
                loginButton
                
                Spacer()
                
                // bottom view
                bottomView
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal)
        .padding(.vertical, 8)
        .alert("Something went wrong", isPresented: $authViewModel.isError) {}
    }
    
    private var logo: some View {
        Image("logobgfree")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    private var titleView: some View {
        Text("Let's Connect With US!")
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    private var forgotButton: some View {
        HStack {
            Spacer()
            Button {
                router.navigate(to: .forgotPassword)
            } label: {
                Text("Forgot Password?")
                    .foregroundStyle(.blue)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
    }
    
    private var loginButton: some View {
        Button {
            Task {
                await authViewModel.login(email: email, password: password)
            }
        } label: {
            Text("Login")
        }
        .buttonStyle(CapsuleButtonStyle(bgColor: .yellow, textColor: .black))
    }
    
    private var line: some View {
        VStack { Divider().frame(height: 1) }
    }
    
    private var bottomView: some View {
        VStack(spacing: 16) {
            lineorView
            //appleButton
            googleButton
            footerView
        }
    }
    
    private var lineorView: some View {
        HStack(spacing: 16) {
            line
            Text("or")
                .fontWeight(.semibold)
            line
        }
        .foregroundStyle(.gray)
    }
    
    private var appleButton: some View {
        Button {
            
        } label: {
            Label("Sign up with Apple", systemImage: "apple.logo")
        }
        .buttonStyle(
            CapsuleButtonStyle(
                bgColor: .black
            )
        )
    }
    
    private var googleButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("Sign up with Google")
                    .foregroundStyle(Color.primary)
            }
        }
        .buttonStyle(
            CapsuleButtonStyle(
                bgColor: .clear,
                textColor: .black,
                hasBorder: true
            )
        )
    }
    
    private var footerView: some View {
        Button {
            router.navigate(to: .createAccount)
        } label: {
            HStack {
                Text("Don't have an account?")
                    .foregroundStyle(Color.primary)
                Text("Sign Up")
                    .foregroundStyle(.blue)
            }
            .fontWeight(.medium)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
        .environmentObject(Router()) 

}

struct CapsuleButtonStyle: ButtonStyle {
    var bgColor: Color = .yellow
    var textColor: Color = .black
    var hasBorder: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(bgColor))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .overlay {
                hasBorder ?
                Capsule()
                    .stroke(.gray, lineWidth: 1) :
                nil
            }
    }
}
