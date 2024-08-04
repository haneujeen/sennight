//
//  PostText.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//

import SwiftUI

struct PostText: View {
    var title: String
    
    var body: some View {
        Text("User achieved \(title) Milestone! Send support?")
    }
}

#Preview {
    PostText(title: "7 Day")
}
