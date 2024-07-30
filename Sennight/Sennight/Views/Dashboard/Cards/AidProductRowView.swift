//
//  FactorRowView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: FactorRowView.swift 파일 이름 수정
//  Edited by 한유진 on 2024-07-29: FactorRowView 코드 변경
//

import SwiftUI

struct AidProductRowView: View {
    @StateObject private var aidProductViewModel = AidProductViewModel()
    var body: some View {
        List(aidProductViewModel.data) { data in
            Text("금연보조제 아이디: \(data.aidProductID)")
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
        }
        .onAppear {
            aidProductViewModel.getAidProduct()
        }
    }
}

#Preview {
    AidProductRowView()
}
