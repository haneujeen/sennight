//
//  SymptomViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-29: Symptom View Model 정의
//

import Foundation
import SwiftUI
import Combine

class SymptomViewModel: ObservableObject {
    @Published var data: [UserSymptom] = []
    @Published var userID = 0
  
    private var cancellables = Set<AnyCancellable>()
    
    func getSymptom() {
        print("금연증상 읽어오기")
        SymptomService.shared.read()
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] data in
                self?.data = data
            }
            .store(in: &cancellables)
    }
}
