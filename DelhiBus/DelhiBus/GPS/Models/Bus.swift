//
//  Bus.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 19/02/25.
//


struct Bus: Identifiable, Equatable {
    let id: String
    let route: String
    let latitude: Double
    let longitude: Double

    static func extractUniqueRoutes(from buses: [Bus]) -> [String] {
        let uniqueRoutes = Set(buses.map { $0.route })
        return Array(uniqueRoutes).sorted() // Sorted for better UX
    }
}

