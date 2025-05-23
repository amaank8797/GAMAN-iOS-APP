//
//  BusViewModel.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 19/02/25.
//


import Foundation


class BusViewModel: ObservableObject {
    @Published var buses: [Bus] = []
    private var timer: Timer?

    //  Computed property for unique routes
    var routes: [String] {
        let uniqueRoutes = Set(buses.map { $0.route }) // Extract unique routes
        return Array(uniqueRoutes).sorted() // Convert to array & sort
    }

    init() {
        fetchBuses()
    }

    /// Fetch buses from the API
    func fetchBuses() {
        guard let url = URL(string: "https://otd.delhi.gov.in/api/realtime/VehiclePositions.pb?key=tOGQf5lsw2B3zzM74aKwYGC2yPctInSo") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let newBuses = PBParser.parseBusData(data)
                DispatchQueue.main.async {
                    if self.buses != newBuses { //Only update if data changes
                        self.buses = newBuses
                    }
                }
            }
        }.resume()
    }

    // Start Auto-Refresh every 15 seconds
    func startAutoRefresh() {
        stopAutoRefresh() // Ensure no duplicate timers
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { _ in
            self.fetchBuses()
        }
    }

    // Stop Auto-Refresh when not needed
    func stopAutoRefresh() {
        timer?.invalidate()
    }

    deinit {
        stopAutoRefresh() // Cleanup when ViewModel is destroyed
    }
}
