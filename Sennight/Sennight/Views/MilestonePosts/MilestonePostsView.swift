//
//  MilestonePostsView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct MilestonePostsView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    MilestonePostCardView(title: "7 Day")
                    MilestonePostCardView(title: "30 Day")
                    MilestonePostCardView(title: "5 Year")
                }
                .padding()
                Spacer()
                NavigationLink(destination: MyMilestonesView()) {
                    Text("My milestones")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
            }
            .background(Color(.systemGray6))
            .navigationBarTitle("Milestone Posts", displayMode: .inline)
        }
    }
}

#Preview {
    MilestonePostsView()
}
