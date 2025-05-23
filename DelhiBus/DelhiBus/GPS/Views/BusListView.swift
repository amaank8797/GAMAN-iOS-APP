//
//  BusListView.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 19/02/25.
//


import SwiftUI

struct BusListView: View {
    @StateObject private var viewModel = BusViewModel()
    @Binding var searchText: String  // Inject searchText from MainTabView

    // Filter routes based on search text
    var filteredRoutes: [String] {
        if searchText.isEmpty {
            return viewModel.routes
        } else {
            return viewModel.routes.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        List(filteredRoutes, id: \.self) { route in
            NavigationLink(destination: BusMapView(route: route)) {
                Text("Route: \(route)")
                    .font(.headline)
            }
        }
        .navigationTitle("Select Route")
        .onAppear {
            viewModel.fetchBuses() // Load Routes
        }
    }
}

