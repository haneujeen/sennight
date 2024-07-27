//
//  FactorViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: FactorViewModel.swift 파일 이름 수정
//  Edited by 김소연 on 2024-07-27: FactorViewModel.swift 코드 작성
//

import Foundation
import SwiftUI
import Combine

class AidProductViewModel: ObservableObject {
    @Published var data: [AidProduct] = []
    @Published var userID = 0
  
    private var cancellables = Set<AnyCancellable>()
    
    func read() {
        print("금연보조제 뷰모델에서 금연보조제 읽어오기")
        AidProductService.shared.read(userID: userID)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { data in
                self.data = data
            }
            .store(in: &cancellables)
    }
}

