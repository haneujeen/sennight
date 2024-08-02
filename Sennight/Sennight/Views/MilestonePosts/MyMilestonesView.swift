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
    @AppStorage("newMaxMilestoneID") private var newMaxMilestoneID: Int = 0
    @State private var showAlert = false
    @State private var maxMilestoneID: Int?
    
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
        .onAppear {
            quitAttemptViewModel.getAllQuitAttempts()
            milestoneViewModel.getAllMilestones()
            milestoneViewModel.getMaxMilestoneID()
            checkForNewMilestones()
        }
        .fullScreenCover(item: $maxMilestoneID) { id in
            if let milestone = Milestone(rawValue: id) {
                NewMilestoneView(milestone: milestone,
                                 quitAttemptID: quitAttemptViewModel.activeQuitAttempt?.id ?? 0,
                                 isMilestoneAdded: $isMilestoneAdded)
                .environmentObject(milestoneViewModel)
            }
        }
        .onChange(of: newMaxMilestoneID) { oldValue, newValue in
            maxMilestoneID = newValue
        }
        .onChange(of: isMilestoneAdded) { oldValue, newValue in
            if newValue && showAboutMilestones {
                print("alert")
                showAlert = true
            }
            quitAttemptViewModel.getAllQuitAttempts()
            milestoneViewModel.getAllMilestones()
            milestoneViewModel.getMaxMilestoneID()
            checkForNewMilestones()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("About Milestones"),
                  message: Text("You’ve just achieved your first milestone. Keep pushing forward and you'll mark more milestones along the way."),
                  dismissButton: .default(Text("Close"), action: {
                showAboutMilestones = false
            }))
        }
    }
    
    private func checkForNewMilestones() {
        for milestone in Milestone.allCases {
            if milestone.timeInterval <= Date().timeIntervalSince(startDate) &&
                milestone.id > newMaxMilestoneID {
                newMaxMilestoneID = milestone.id
                milestoneViewModel.maxMilestoneID = milestone.id
                break
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
