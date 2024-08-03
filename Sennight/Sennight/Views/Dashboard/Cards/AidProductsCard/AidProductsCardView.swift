//
//  FactorsCardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: FactorsCardView.swift 파일 이름 수정
//  Edited by 한유진 on 2024-08-03: Updated AidProductsCardView.swift
//

import SwiftUI

struct AidProductsCardView: View {
    @StateObject private var aidProductViewModel = AidProductViewModel()
    
    @State private var isPresentingNewFactorSheet = false
    
    var body: some View {
        Section(header: Text("Cessation Aids")) {
            ForEach(aidProductViewModel.userAidProducts, id: \.ID) { userAidProduct in
                AidProductRowView(userAidProduct: userAidProduct)
                    .environmentObject(aidProductViewModel)
            }
            
            AddYourAidProductRow()
                .onTapGesture {
                    isPresentingNewFactorSheet = true
                }
                .sheet(isPresented: $isPresentingNewFactorSheet) {
                    NewAidProductSheet(isPresentingNewFactorSheet: $isPresentingNewFactorSheet)
                        .environmentObject(aidProductViewModel)
                }
        }
        .onAppear(perform: {
            aidProductViewModel.getAidProduct()
        })
    }
}

#Preview {
    List {
        AidProductsCardView()
            .listRowBackground(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Theme.lavender.mainColor)
            )
    }
}
