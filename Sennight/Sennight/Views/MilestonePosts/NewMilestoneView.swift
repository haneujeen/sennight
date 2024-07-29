// NewMilestoneView.swift
// Sennight
//
// Created by 한유진 on 7/29/24.
//

import SwiftUI

struct NewMilestoneView: View {
    @EnvironmentObject var milestoneViewModel: MilestoneViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var milestone: Milestone?
    @State var quitAttemptID: Int?
    @Binding var isMilestoneAdded: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "trophy.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            
            Text(milestone?.title ?? "")
            
            Text("Click the button below and get your milestone.")
                .multilineTextAlignment(.center)
            
            Button(action: {
                addMilestone()
            }) {
                Text("Add New Milestone")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.8).edgesIgnoringSafeArea(.all))
        
    }
    
    private func addMilestone() {
        guard let milestoneID = milestone?.id, let quitAttemptID = quitAttemptID else {
            return
        }
        milestoneViewModel.addMilestoneForUser(milestoneID: milestoneID, quitAttemptID: quitAttemptID)
        withAnimation {
            isMilestoneAdded = true
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                isMilestoneAdded = false
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    NewMilestoneView(milestone: .oneWeek, quitAttemptID: 0, isMilestoneAdded: .constant(true))
        .environmentObject(MilestoneViewModel())
}
