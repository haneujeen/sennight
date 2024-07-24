//
//  QuitAttemptViewModel.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: Quit Attempt ViewModel 코드 생성
//

import Foundation
import Combine
import SwiftUI

class QuitAttemptViewModel: ObservableObject{
    
    @Published var userID = 0
    @Published var startDate = ""
    @Published var attemptID = 0
    @Published var endDate = ""
    @Published var isActive = false
    @Published var onboardingToken = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    //금연 시간 등록
    func create(completion: @escaping (Bool)->Void) {
        QuitAttemptService.shared.createQuitAttempt(onboardingToken: onboardingToken, startDate: startDate, userID: userID)
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
