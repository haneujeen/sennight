//
//  FactorsCardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct FactorsCardView: View {
    @State private var isPresentingUpdateFactorSheet = false
    
    var body: some View {
        Section(header: Text("Products")) {
            ForEach(0..<3) { _ in
                FactorRowView()
                    .onTapGesture {
                        isPresentingUpdateFactorSheet = true
                    }
                    .sheet(isPresented: $isPresentingUpdateFactorSheet) {
                        UpdateFactorSheet(isPresentingUpdateFactorSheet: $isPresentingUpdateFactorSheet)
                    }
            }
        }
    }
}

#Preview {
    FactorsCardView()
}
