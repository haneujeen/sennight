//
//  MotivationViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-19: Motivation ViewModel 코드 생성
//  Edited by 한유진 on 2024-07-28: Refactor
//

import Foundation
import SwiftUI
import Combine

class MotivationViewModel: ObservableObject {
    @Published var motivationID = 0
    @Published var userMotivationID = 0
    @Published var message: String?
    @Published var motivation: UserMotivation?
    
    private var cancellables = Set<AnyCancellable>()
    
    func createMotivation(completion: @escaping (Bool)->Void) {
        MotivationService.shared.createMotivation(motivationID: motivationID, message: message)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: 
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completion(response.status)
                if response.data != nil {
                    self.motivation = response.data
                }
            }.store(in: &cancellables)
    }
    
    /**
     * TODO: 서버 수정
     * See: Nil user motivation 응답 예시 --
         {
             "status": true,
             "detail": "",
             "data": null
         }
     */
    func getMotivation(completion: @escaping (Bool)->Void) {
        MotivationService.shared.getMotivation()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: 
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                if response.data != nil {
                    self.motivation = response.data
                    completion(response.status)
                }
            }.store(in: &cancellables)
    }
}
