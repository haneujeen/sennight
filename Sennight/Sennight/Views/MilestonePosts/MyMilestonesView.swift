//
//  MyMilestonesView.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//

import SwiftUI

struct MyMilestonesView: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    @StateObject var milestoneViewModel = MilestoneViewModel()
    
    @AppStorage("showAboutMilestones") private var showAboutMilestones: Bool = true
    @State private var isMilestoneAdded = false
    @State private var selectedOption = 0
    @AppStorage("newMaxMilestoneID") private var newMaxMilestoneID: Int?
    @State private var showAlert = false

    private var startDate: Date {
        dateFormatter().date(from: quitAttemptViewModel.activeQuitAttempt?.startDate ?? "") ?? Date()
    }

    var body: some View {
        VStack {
            Picker("Filter", selection: $selectedOption) {
                Text("All").tag(0)
                Text("My Quit History").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if selectedOption == 0 {
                AllMilestonesListView()
                    .environmentObject(milestoneViewModel)
            } else {
                SortedMilestonesListView()
                    .environmentObject(quitAttemptViewModel)
                    .environmentObject(milestoneViewModel)
            }
        }
        .onAppear(perform: {
            quitAttemptViewModel.getAllQuitAttempts()
            milestoneViewModel.getAllMilestones()
            milestoneViewModel.getMaxMilestoneID()
            checkForNewMilestones()
        })
        .fullScreenCover(item: $newMaxMilestoneID) { id in
            if let milestone = Milestone(rawValue: id) {
                NewMilestoneView(milestone: milestone, 
                                 quitAttemptID: quitAttemptViewModel.activeQuitAttempt?.id ?? 0,
                                 isMilestoneAdded: $isMilestoneAdded)
                    .environmentObject(milestoneViewModel)
            }
        }
        .onChange(of: isMilestoneAdded, { oldValue, newValue in
            if newValue && showAboutMilestones {
                showAlert = true
                showAboutMilestones = false
            }
        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text("About Milestones"),
                  message: Text("You’ve just achieved your first milestone. Keep pushing forward and you'll mark more milestones along the way."),
                  dismissButton: .default(Text("Close")))
        }
    }

    private func checkForNewMilestones() {
        for milestone in Milestone.allCases {
            if let storedID = newMaxMilestoneID {
                if milestone.id > storedID && milestone.timeInterval <= Date().timeIntervalSince(startDate) {
                    newMaxMilestoneID = milestone.id
                    milestoneViewModel.maxMilestoneID = milestone.id
                    break
                }
            }
        }
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}

#Preview {
    MyMilestonesView()
        .environmentObject(QuitAttemptViewModel())
}
