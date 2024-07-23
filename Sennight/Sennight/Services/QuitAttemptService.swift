//
//  QuitAttemptService.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: Quit Attempt Service 코드 생성
//

import Foundation
import Combine
import Alamofire

class QuitAttemptService {
    static let shared = QuitAttemptService()
    
    let HOST = Settings.shared.HOST
    
    /// Creates ongoing quitting smoking attempt.
    func createQuitAttempt(userId: Int, quitAttemptData: [String: Any]) -> QuitAttempt {
        // Implementation here
    }
    
    /// Retrieves user's most recent quitting smoking attempt.
    func getLatestQuitAttempt(userId: Int) -> QuitAttempt? {
        // Implementation here
    }
    
    /// Retrieves all of user's quitting smoking attempts.
    func getAllQuitAttempts(userId: Int) -> [QuitAttempt] {
        // Implementation here
    }
    
    /// Deletes a quitting smoking attempt.
    func deleteQuitAttempt(userId: Int, attemptId: Int) {
        // Implementation here
    }
    
    /// Updates a quitting smoking attempt.
    func updateQuitAttempt(userId: Int, attemptId: Int, quitAttemptData: [String: Any]) -> QuitAttempt {
        // Implementation here
    }
    
    /// Retrieves milestones associated with a quitting smoking attempt.
    func getMilestonesForQuitAttempt(userId: Int, attemptId: Int) -> [Milestone] {
        // Implementation here
    }
}
