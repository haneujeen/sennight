//
//  AddYourAidProductRow.swift
//  Sennight
//
//  Created by 한유진 on 8/3/24.
//

import SwiftUI

struct AddYourAidProductRow: View {
    var body: some View {
        HStack {
            Image(systemName: "plus.circle")
            Text("Add your cessation aids")
                .fontWeight(.bold)
        }
        .foregroundStyle(Theme.teal.mainColor)
        .padding(10)
    }
}

#Preview {
    AddYourAidProductRow()
}
