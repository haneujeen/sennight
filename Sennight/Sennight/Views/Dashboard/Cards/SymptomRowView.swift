//
//  SymptomRowView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-30: SymptomRowView 코드 추가
//

import SwiftUI

struct SymptomRowView: View {
    @StateObject private var symptomViewModel = SymptomViewModel()
    var body: some View {
        List(symptomViewModel.data) { data in
            Text("Symptom row")
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
        }
        .onAppear {
            symptomViewModel.getSymptom()
        }
    }
}

#Preview {
    SymptomRowView()
}
