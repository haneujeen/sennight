//
//  MotivationViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-19: Motivation ViewModel 코드 생성
//

import Foundation
import SwiftUI
import Combine

class MotivationViewModel: ObservableObject {
    
    @Published var userId = 0
    @Published var motivationId = 0
    @Published var userMotivationId = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    //금연 동기 등록
    func creat(completion: @escaping (Bool)->Void) {
        MotivationService.shared.createMO(userId: userId, motivationId: motivationId)
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
    //금연 동기 등록
    func read(completion: @escaping (Bool)->Void) {
        MotivationService.shared.readMO(userId: userId)
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
    //금연 동기 수정
    func update(completion: @escaping (Bool)->Void) {
        MotivationService.shared.updateMO(userId: userId, motivationId: motivationId, userMotivationId: userMotivationId)
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
    //금연 동기 삭제
    func delete(completion: @escaping (Bool)->Void) {
        MotivationService.shared.deleteMO(userMotivationId: userMotivationId)
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
