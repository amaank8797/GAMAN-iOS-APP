//
//  MainTabView.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//


import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router
    @State private var selectedIndex: Int = 0
    @State private var searchText = "" // Search Query for BusListView

    var body: some View {
        NavigationStack {
            VStack {
                // Show search bar only on BusListView (tab 0)
                if selectedIndex == 0 {
                    SearchBar(text: $searchText)
                        .padding(.horizontal)
                }

                TabView(selection: $selectedIndex) {
                    // BusListView Tab (Only this tab gets the search functionality)
                    BusListView(searchText: $searchText)
                        .tabItem {
                            Image(systemName: "bus.fill")
                            Text("Bus List")
                        }
                        .tag(0)

                    // Feedback Tab
                    FeedbackView()
                        .tabItem {
                            Image(systemName: "pencil.circle.fill")
                            Text("Feedback")
                        }
                        .tag(1)

                    // Profile Tab
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Account")
                        }
                        .tag(2)
                    
                    
//                    KnowYourRouteView()
//                        .tabItem {
//                            Image(systemName: "map")
//                            Text("Know Route")
//                        }
//                        .tag(3)
                    
                    
                }
                .navigationTitle(tabTitle)
                .navigationBarTitleDisplayMode(.inline)
                .accentColor(.yellow)
            }
        }
    }

    // Compute the tab title based on the selected index
    private var tabTitle: String {
        switch selectedIndex {
        case 0: return "Bus List"
        case 1: return "Feedback"
        case 2: return "Account"
        default: return ""
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthViewModel())
        .environmentObject(Router())
}
