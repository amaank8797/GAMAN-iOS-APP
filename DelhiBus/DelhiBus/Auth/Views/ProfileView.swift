//
//  ProfileView.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//


import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        if let user = authViewModel.currentUser {
            List {
                Section {
                    HStack(spacing: 16) {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 70, height: 70)
                            .background(Color(.lightGray))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text(user.email)
                                .font(.footnote)
                        }
                    }
                }
                
                Section("Accounts") {
                    // Sign Out Button
                    Button {
                        authViewModel.signOut()
                    } label: {
                        Label {
                            Text("Sign Out")
                                .foregroundStyle(Color.primary)
                        } icon: {
                            Image(systemName: "arrow.left.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    
                    // DELETE ACCOUNT BUTTON HIDDEN
                    // This button is removed or hidden using a condition
                    // If you want to bring it back later, you can simply enable it again
                    
                    // Example: Use a condition if needed (e.g., admin users only)
                    /*
                    if false {
                        Button {
                            Task {
                                await authViewModel.deleteAccount()
                            }
                        } label: {
                            Label {
                                Text("Delete Account")
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    */
                }
            }
        } else {
            ProgressView("Please wait...")
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
