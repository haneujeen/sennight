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
    @Published var latestQuitAttempt: QuitAttempt?
    @Published var milestones: [Milestone] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    /// Creates a new quitting smoking attempt.
    func createQuitAttempt() {
        
    }
    
    /**
     func fetchSales() {
         SaleService.shared.fetchSales()
             .sink { completion in
                 switch completion {
                 case .finished:
                     break
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             } receiveValue: { documents in
                 self.sales = documents
             }
             .store(in: &cancellables) // Retain counter += 1

     }
     
     */
    /// Retrieves the most recent quitting smoking attempt for the user and updates the `latestQuitAttempt` property.
    func getLatestQuitAttempt() {
        guard let userID = UserService.shared.getUserID() else {
            return
        }
        QuitAttemptService.shared.getLatestQuitAttempt(userID: userID)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { quitAttempt in
                self.latestQuitAttempt = quitAttempt
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
