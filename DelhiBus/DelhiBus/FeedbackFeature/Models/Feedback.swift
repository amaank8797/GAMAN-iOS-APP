//
//  Feedback.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//


import Foundation

struct Feedback: Identifiable, Codable {
    let id: String // Firebase document ID
    let mood: String
    let email: String
    let feedback: String
    let timestamp: String // Now a formatted string
    
    init(id: String = UUID().uuidString, mood: String, email: String, feedback: String, timestamp: String = Feedback.currentDate()) {
        self.id = id
        self.mood = mood
        self.email = email
        self.feedback = feedback
        self.timestamp = timestamp
    }

    // Convert to dictionary for Firebase
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "mood": mood,
            "email": email,
            "feedback": feedback,
            "timestamp": timestamp // Now stores the formatted string
        ]
    }

    // Helper to get the current date in a specific format
    static func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Choose your desired format
        return formatter.string(from: Date())
    }
}


