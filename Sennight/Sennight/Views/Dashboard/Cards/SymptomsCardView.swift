//
//  SymptomsCardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct SymptomsCardView: View {
    var body: some View {
        Section(header: Text("Symptoms")) {
            VStack {
                ForEach(0..<3) { _ in
                    SymptomRowView()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    SymptomsCardView()
}
