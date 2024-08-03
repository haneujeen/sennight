//
//  FactorViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: FactorViewModel.swift 파일 이름 수정
//  Edited by 한유진 on 2024-08-03: Updated AidProductViewModel.swift
//

import SwiftUI
import Combine

class AidProductViewModel: ObservableObject {
    @Published var aidProductID = 0
    @Published var startDate = "2024-08-01"
    @Published var userAidProductID = 0
    
    @Published var userAidProducts: [UserAidProduct] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func addAidProduct(completionHandler: @escaping (Bool)->Void) {
        AidProductService.shared.addAidProduct(aidProductID: aidProductID, startDate: startDate)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completionHandler(response.status)
            }.store(in: &cancellables)
    }
    
    func getAidProduct() {
        AidProductService.shared.getAllAidProduct()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                if let userAidProducts = response.data {
                    self.userAidProducts = userAidProducts
                }
            }
            .store(in: &cancellables)
    }
    
    func deleteAidProduct(completionHandler: @escaping (Bool)->Void) {
        AidProductService.shared.deleteAidProduct(userAidProductID: userAidProductID)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completionHandler(response.status)
                                if response.status {
                                    self.userAidProducts.removeAll { $0.ID == self.userAidProductID }
                                }
            }
            .store(in: &cancellables)
    }
}
