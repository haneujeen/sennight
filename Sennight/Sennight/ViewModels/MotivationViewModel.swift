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
    @Published var userID = 0
    @Published var motivationID = 0
    @Published var userMotivationID = 0
    @Published var message: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    //금연 동기 등록
    func createMotivation(completion: @escaping (Bool)->Void) {
        MotivationService.shared.createMotivation(motivationID: motivationID, message: message)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                print("서버응답: \(response)")
                completion(response.status)
            }.store(in: &cancellables)
    }
}
