//
//  SupportIcon.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//

import SwiftUI

struct SupportIcon: View {
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .foregroundColor(.red)
    }
}

#Preview {
    SupportIcon()
}
