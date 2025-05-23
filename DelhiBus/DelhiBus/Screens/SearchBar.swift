//
//  SearchBar.swift
//  DelhiBus
//
//  Created by Amaan Amaan on 02/03/25.
//


import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search Route", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
