//
//  BusMapView.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 19/02/25.
//


import SwiftUI
import MapKit

struct BusMapView: View {
    let route: String // Selected Route
    @StateObject private var viewModel = BusViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090), // Default to Delhi
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var timer: Timer?
    @State private var isRotating = false //  Animation state

    // Filter buses for the selected route
    var filteredBuses: [Bus] {
        viewModel.buses.filter { $0.route == route }
    }

    var body: some View {
        ZStack {
            //  Map View
            Map(coordinateRegion: $region, annotationItems: filteredBuses) { bus in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: bus.latitude, longitude: bus.longitude)) {
                    VStack(spacing: 2) {
                        Text(bus.route) // Show Route Number
                            .font(.caption)
                            .bold()
                            .padding(5)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(5)
                            .shadow(radius: 3)

                        Image(systemName: "bus.fill") // Bus Symbol
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .background(Circle().fill(Color.white).shadow(radius: 5))
                    }
                }
            }

            // 🔄 Refresh Button (Top-Right)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1.5)) { // 🔄 Smooth rotation
                            isRotating = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isRotating = false
                        }
                        viewModel.fetchBuses() // 🔄 Manually refresh bus data
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                            .padding(10)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                            .rotationEffect(.degrees(isRotating ? 1080 : 0)) // 🔄 360° x 3
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .navigationTitle("Route \(route)")
        .onAppear {
            viewModel.fetchBuses() // Initial Fetch
            startAutoRefresh()
            if let firstBus = filteredBuses.first {
                region.center = CLLocationCoordinate2D(latitude: firstBus.latitude, longitude: firstBus.longitude)
            }
        }
        .onDisappear {
            stopAutoRefresh()
        }
    }

    //  Start Auto-Refresh
    func startAutoRefresh() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            viewModel.fetchBuses()
        }
    }

    //  Stop Auto-Refresh when leaving the screen
    func stopAutoRefresh() {
        timer?.invalidate()
    }
}
