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
    @Published var quitAttempts: [QuitAttempt] = []
    @Published var activeQuitAttempt: QuitAttempt?
    @Published var milestones: [Milestone] = []
    @Published var isActiveQuitAttempt = false
    
    private var cancellables = Set<AnyCancellable>()
    
    /// Creates a new quitting smoking attempt.
    func createQuitAttempt() {
        
    }
    
    /*
     
     */
    /// Retrieves the most recent quitting smoking attempt for the user and updates the `latestQuitAttempt` property.
    func getActiveQuitAttempt() {
        guard let userID = UserService.shared.getUserID() else {
            return
        }
        QuitAttemptService.shared.getActiveQuitAttempt(userID: userID)
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
