//
//  FeedbackView.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//


import SwiftUI

struct FeedbackView: View {
    @State private var selectedMood: String? = nil
    @State private var email: String = ""
    @State private var feedback: String = ""
    @State private var showAlert = false

    @StateObject private var feedbackViewModel = FeedbackViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Header
            Text("How are you feeling today?")
                .font(.headline)
                .padding(.top)

            // Mood Selection
            HStack(spacing: 30) {
                FeedbackMoodView(mood: "Great", icon: "face.smiling", color: .yellow, selectedMood: $selectedMood)
                FeedbackMoodView(mood: "Good", icon: "sun.max.fill", color: .yellow, selectedMood: $selectedMood)
                FeedbackMoodView(mood: "Okay", icon: "moon.fill", color: .yellow, selectedMood: $selectedMood)
                FeedbackMoodView(mood: "Tired", icon: "cup.and.saucer.fill", color: .yellow, selectedMood: $selectedMood)
            }
            .padding()

            // Email Input
            VStack(alignment: .leading) {
                Text("Your Email")
                    .font(.subheadline)
                    .bold()
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
            }
            .padding(.horizontal)

            // Feedback Input
            VStack(alignment: .leading) {
                Text("Your Feedback")
                    .font(.subheadline)
                    .bold()
                TextEditor(text: $feedback)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            // Submit Button
            Button(action: {
                Task {
                    if let mood = selectedMood, !email.isEmpty, !feedback.isEmpty {
                        await feedbackViewModel.submitFeedback(mood: mood, email: email, feedback: feedback)
                        showAlert = true // Trigger popup
                    }
                }
            }, label: {
                Text("Submit Feedback")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.primary)
                    .cornerRadius(10)
            })
            .padding(.horizontal)
            .padding(.bottom)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(feedbackViewModel.isFeedbackSubmitted ? "Success" : "Error"),
                    message: Text(feedbackViewModel.isFeedbackSubmitted ? "Feedback submitted successfully!" : (feedbackViewModel.errorMessage ?? "An error occurred.")),
                    dismissButton: .default(Text("OK"), action: resetForm) // Call resetForm after alert
                )
            }

            Spacer()
        }
        .padding()
    }

    // Function to reset form fields
    private func resetForm() {
        selectedMood = nil
        email = ""
        feedback = ""
    }
}


struct FeedbackMoodView: View {
    let mood: String
    let icon: String
    let color: Color
    @Binding var selectedMood: String?

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(selectedMood == mood ? color : .gray)
                .onTapGesture {
                    selectedMood = mood
                }
            Text(mood)
                .font(.footnote)
        }
    }
}

#Preview {
    FeedbackView()
}

