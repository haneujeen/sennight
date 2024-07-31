//
//  FactorsCardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: FactorsCardView.swift 파일 이름 수정
//

import SwiftUI

struct AidProductsCardView: View {
    @State private var isPresentingUpdateFactorSheet = false
    
    var body: some View {
        Section(header: Text("Products")) {
            ForEach(0..<3) { _ in
                AidProductRowView()
                    .onTapGesture {
                        isPresentingUpdateFactorSheet = true
                    }
                    .sheet(isPresented: $isPresentingUpdateFactorSheet) {
                        UpdateAidProductSheet(isPresentingUpdateFactorSheet: $isPresentingUpdateFactorSheet)
                    }
            }
        }
    }
}

#Preview {
    AidProductsCardView()
}
