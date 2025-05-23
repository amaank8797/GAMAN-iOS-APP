//
//  FeedbackViewModel.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//


import Foundation
import FirebaseFirestore

class FeedbackViewModel: ObservableObject {
    @Published var isFeedbackSubmitted = false
    @Published var errorMessage: String?

    private let db = Firestore.firestore()

    func submitFeedback(mood: String, email: String, feedback: String) async {
        // Create Feedback object
        let feedbackData = Feedback(mood: mood, email: email, feedback: feedback)

        do {
            // Save feedback to Firebase
            try await db.collection("feedbacks").document(feedbackData.id).setData(feedbackData.toDictionary())
            DispatchQueue.main.async {
                self.isFeedbackSubmitted = true // Show success message
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isFeedbackSubmitted = false
            }
        }
    }
}

