//
//  MotivationCardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-28: MotivationCardView 수정
//

import SwiftUI
import Alamofire

struct MotivationCardView: View {
    @StateObject private var MotivationviewModel = MotivationViewModel()
    
    var body: some View {
            VStack {
                if MotivationviewModel.isLoading {
                    ProgressView("Loading...")
                } else if let motivation = MotivationviewModel.userMotivation {
                    Text("Category: \(Motivation(rawValue: motivation.motivationID)?.category ?? "Unknown")")
                        .font(.headline)
                    Text("Motivation Message:")
                        .font(.subheadline)
                    Text(motivation.message ?? "unknown")
                        .font(.body)
                } else {
                    Text("No motivation available")
                }
            }
            .onAppear {
                MotivationviewModel.getMotivation()
            }
            .alert("Error", isPresented: $MotivationviewModel.showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Failed to load motivation. Please try again.")
            }
        }
}

#Preview {
    MotivationCardView()
}

