//
//  NewFactorSheet.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: NewFactorSheet.swift 파일 이름 수정
//

import SwiftUI

struct NewAidProductSheet: View {
    @EnvironmentObject var aidProductViewModel: AidProductViewModel
    @State private var selectedCategory: String = "NRT"
    @State private var selectedAidProduct: AidProduct?
    @Binding var isPresentingNewFactorSheet: Bool

    let categories = ["NRT", "Pill", "Other"]

    var filteredAidProducts: [AidProduct] {
        let excludedProducts = aidProductViewModel.userAidProducts.map { $0.aidProductID }
        return AidProduct.allCases.filter { aidProduct in
            aidProduct.category == selectedCategory && !excludedProducts.contains(aidProduct.rawValue)
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List(filteredAidProducts, id: \.self) { aidProduct in
                    HStack {
                        Text(aidProduct.name)
                        Spacer()
                        if aidProduct == selectedAidProduct {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedAidProduct = aidProduct
                    }
                }
            }
            .navigationTitle("New Cessation Aid")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        if let selectedAidProduct = selectedAidProduct {
                            aidProductViewModel.aidProductID = selectedAidProduct.rawValue
                            aidProductViewModel.addAidProduct { status in
                                if status {
                                    aidProductViewModel.getAidProduct()
                                    isPresentingNewFactorSheet = false
                                }
                            }
                        }
                    }) {
                        Text("Save")
                    }
                    .disabled(selectedAidProduct == nil)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresentingNewFactorSheet = false
                    }
                }
            }
        }
    }
}

#Preview {
    NewAidProductSheet(isPresentingNewFactorSheet: .constant(true))
        .environmentObject(AidProductViewModel())
}
