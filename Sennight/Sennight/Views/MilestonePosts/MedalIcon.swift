//
//  MedalIcon.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//

import SwiftUI

struct MedalIcon: View {
    var body: some View {
        Image(systemName: "medal.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .foregroundColor(.yellow)
    }
}

#Preview {
    MedalIcon()
}
