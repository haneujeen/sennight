//
//  MilestonePostCardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct MilestonePostCardView: View {
    var title: String
    
    var body: some View {
        HStack {
            MedalIcon()
            PostText(title: title)
            Spacer()
            SupportIcon()
        }
        .padding()
        .background(.white)
        .cornerRadius(15)
    }
}

#Preview {
    MilestonePostCardView(title: "7 Day")
}
