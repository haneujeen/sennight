//
//  QuitAttemptViewModel.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: Quit Attempt ViewModel 코드 생성
//  Edited by 한유진 on 2024-07-24
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
    @Published var quitAttempts: [QuitAttempt] = []
    @Published var activeQuitAttempt: QuitAttempt?
    @Published var milestones: [UserMilestone] = []
    @Published var isActiveQuitAttempt = false
    
    private var cancellables = Set<AnyCancellable>()
    
    /// Creates a new quitting smoking attempt.
    func createQuitAttempt() {
        
    }
    
    /*
     
     */
    /// Retrieves the most recent quitting smoking attempt for the user and updates the `latestQuitAttempt` property.
    func getActiveQuitAttempt() {
        QuitAttemptService.shared.getActiveQuitAttempt()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { quitAttempt in
                self.activeQuitAttempt = quitAttempt
                self.isActiveQuitAttempt = true
            }
            .store(in: &cancellables)
    }
    
    /// Retrieves all quitting smoking attempts for the user and updates the `quitAttempts` property.
    func getAllQuitAttempts() {
        QuitAttemptService.shared.getAllQuitAttempts()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { quitAttempts in
                self.quitAttempts = quitAttempts
            }
            .store(in: &cancellables)
    }
    
    /// Deletes a quitting smoking attempt.
    func deleteQuitAttempt() {
        
    }
    
    /// Updates an existing quitting smoking attempt.
    func updateQuitAttempt() {
        
    }
    
    /// Retrieves milestones associated with a specific quitting smoking attempt and updates the `milestones` property.
    func getMilestonesForQuitAttempt() {
        
    }
}
