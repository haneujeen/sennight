//
//  AllMilestonesListView.swift
//  Sennight
//
//  Created by 한유진 on 7/29/24.
//

import SwiftUI

struct AllMilestonesListView: View {
    @EnvironmentObject var milestoneViewModel: MilestoneViewModel
    
    var body: some View {
        List {
            ForEach(Milestone.allCases) { milestone in
                VStack(alignment: .center) {
                    milestone.icon
                        .frame(width: 50, height: 50)
                    Text(milestone.title)
                    HStack {
                        Text(milestone.message)
                        Spacer()
                    }
                }
                .blur(radius: milestone.id > milestoneViewModel.maxMilestoneID ? 7 : 0)
            }
        }
    }
}

#Preview {
    AllMilestonesListView()
        .environmentObject(MilestoneViewModel())
}
