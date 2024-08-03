//
//  FactorRowView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: FactorRowView.swift 파일 이름 수정
//

import SwiftUI

struct AidProductRowView: View {
    @EnvironmentObject var aidProductViewModel: AidProductViewModel
    @StateObject private var deleteViewModel = AidProductViewModel()
    
    var userAidProduct: UserAidProduct
    var aidProduct: AidProduct {
            AidProduct(rawValue: userAidProduct.aidProductID) ?? .bupropion
        }
    
    var body: some View {
        HStack {
            Text(aidProduct.name)
            Text(aidProduct.category)
                .font(.subheadline)
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
            Spacer()
            Button(action: {
                aidProductViewModel.userAidProductID = userAidProduct.ID
                aidProductViewModel.deleteAidProduct { status in
                    if status {
                        aidProductViewModel.getAidProduct()
                    }
                }
            }) {
                Image(systemName: "x.circle.fill")
                    .foregroundStyle(.gray)
            }
        }
        .padding(10)
    }
}

#Preview {
    AidProductRowView(userAidProduct: UserAidProduct(ID: 0, userID: 0, aidProductID: 1, startDate: "2024-08-03"))
}
