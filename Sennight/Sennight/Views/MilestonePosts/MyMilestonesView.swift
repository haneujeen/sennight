//
//  MyMilestonesView.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//  Edited by 김소연 on 2024-07-25: Milestone view 정의
//

import SwiftUI
var milestoneMessages = [
    "Congratulations on reaching 7 days of being smoke-free! Your determination inspires us. Keep it up!",
    "Two weeks smoke-free! It’s going to get easier from here. Stay strong!",
    "Congrats on hitting the 3-week mark without smoking! You are a superstar."
]

struct MyMilestonesView: View {
    @EnvironmentObject var logIn: LoginViewModel
    @StateObject var milestionesViewModel = MilestoneViewModel()
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    // List 사용하기
                    List(milestionesViewModel.data) { data in
                        Text("마일스톤 아이디: \(data.milestoneID)")
                        if data.milestoneID - 1 < milestoneMessages.count && data.milestoneID - 1 >= 0 {
                            Text(milestoneMessages[data.milestoneID - 1])
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .onAppear(perform: {
                        milestionesViewModel.read()
                    })
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

#Preview {
    MyMilestonesView()
}
