//
//  SortedMilestonesListView.swift
//  Sennight
//
//  Created by 한유진 on 7/29/24.
//

import SwiftUI

struct SortedMilestonesListView: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    @EnvironmentObject var milestoneViewModel: MilestoneViewModel
    
    var groupedMilestones: [Int: [UserMilestone]] {
        Dictionary(grouping: milestoneViewModel.milestones, by: { $0.quitAttemptID })
    }
    
    var sortedAttemptIds: [Int] {
        groupedMilestones.keys.sorted(by: >)
    }
    
    private var startDate: Date {
        dateFormatter().date(from: quitAttemptViewModel.activeQuitAttempt?.startDate ?? "") ?? Date()
    }
    
    var body: some View {
        List {
            ForEach(sortedAttemptIds, id: \.self) { attemptID in
                if let quitAttempt = quitAttemptViewModel.quitAttempts.first(where: { $0.id == attemptID }) {
                    Section(header: Text("\(formattedDate(from: quitAttempt.startDate))")) {
                        if let userMilestones = groupedMilestones[attemptID] {
                            ForEach(userMilestones, id: \.id) { userMilestone in
                                if let milestone = Milestone(rawValue: userMilestone.milestoneID) {
                                    HStack {
                                        milestone.icon
                                            .frame(width: 28, height: 28)
                                        Text(milestone.title)
                                        Spacer()
                                        Text("Date achieved: \(formattedDate(from: userMilestone.dateAchieved))")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SortedMilestonesListView()
        .environmentObject(QuitAttemptViewModel())
        .environmentObject(MilestoneViewModel())
}
