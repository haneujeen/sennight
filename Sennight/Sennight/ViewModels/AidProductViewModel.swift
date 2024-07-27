//
//  FactorViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: FactorViewModel.swift 파일 이름 수정
//

import SwiftUI
import Combine

class AidProductViewModel: ObservableObject {
    @Published var aidProducts: [AidProduct] = []
    
    private var cancellables = Set<AnyCancellable>()
    
//    func getAidProducts() {
//        guard let userID = UserService.shared.getUserID() else {
//            return
//        }
//        AidProductService.shared.getAidProducts(userID: userID)
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            } receiveValue: { aidProducts in
//                self.aidProducts = aidProducts
//            }
//            .store(in: &cancellables)
//    }
}
