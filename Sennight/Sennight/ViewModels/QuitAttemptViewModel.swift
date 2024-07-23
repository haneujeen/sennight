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
    
    private var cancellables = Set<AnyCancellable>()
    
    //금연 시간 등록
    func creat(completion: @escaping (Bool)->Void) {
        QuitAttemptService.shared.createQuitAttempt(startDate: startDate, userID: userID)
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
    //금연 시간 확인
    func read(completion: @escaping (Bool)->Void) {
        QuitAttemptService.shared.readQuitAttempt(userID: userID)
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
    
    //금연 시도 모두 확인
    // TODO: readAll() 추가
    
    //금연 시간 변경
    func Update(completion: @escaping (Bool)->Void) {
        QuitAttemptService.shared.updateQuitAttempt(attemptID: attemptID, startDate: startDate, endDate: endDate, isActive: isActive)
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
    //금연 시간 삭제
    func delete(completion: @escaping (Bool)->Void) {
        QuitAttemptService.shared.deleteQuitAttempt(attemptID: attemptID, startDate: startDate, endDate: endDate, isActive: isActive)
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
    //금연 시간에 따른 메달 제공
    func ReadMilestiones(completion: @escaping (Bool)->Void) {
        QuitAttemptService.shared.ReadMilestionesQuitAttempt(attemptID: attemptID, startDate: startDate, endDate: endDate, isActive: isActive)
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
