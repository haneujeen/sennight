//
//  ActivityRowView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-30: ActivityRowView 코드 추가
//

import SwiftUI

struct ActivityRowView: View {
    @StateObject private var activityViewModel = ActivityViewModel()
    var body: some View {
        List(activityViewModel.data) { data in
            Text("금단 증상 아이디: \(data.activityID)")
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
        }
        .onAppear {
            activityViewModel.getActivity()
        }
    }
}

#Preview {
    ActivityRowView()
}

