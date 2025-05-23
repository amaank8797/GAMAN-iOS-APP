//
//  to.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 18/02/25.
//


import Foundation
import SwiftProtobuf

struct PBParser {
    static func parseBusData(_ data: Data) -> [Bus] {
        do {
            let feed = try TransitRealtime_FeedMessage(serializedData: data)
            var buses: [Bus] = []

            for entity in feed.entity {
                if let vehicle = entity.hasVehicle ? entity.vehicle : nil,
                   let position = vehicle.hasPosition ? vehicle.position : nil,
                   let routeID = vehicle.trip.hasRouteID ? vehicle.trip.routeID : nil {

                    let id = entity.id
                    let latitude = Double(position.latitude)
                    let longitude = Double(position.longitude)
                    let route = routeID
                    
                    let bus = Bus(id: id, route: route, latitude: latitude, longitude: longitude)
                    buses.append(bus)

                    print("Parsed Bus - ID: \(id), Route: \(route), Lat: \(latitude), Lon: \(longitude)")
                }
            }

            return buses
        } catch {
            print("Error decoding Protocol Buffer: \(error)")
            return []
        }
    }
}
