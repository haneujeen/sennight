//
//  SmokingHabitViewModel.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//

import Foundation
import Combine
import SwiftUI

class SmokingHabitViewModel: ObservableObject {
    @Published var userId = 0
    @Published var habitId = 0
    @Published var dailyCigarettes = 0
    @Published var cigarettePrice = 0
    @Published var firstCigarette = ""
    @Published var smokingYears = 0
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    
    //흡연 정보 등록
    func creart(completion: @escaping (Bool)->Void) {
        SmokingHabitService.shared.createSH(userId: userId, dailyCigarettes: dailyCigarettes, cigarettePrice: cigarettePrice, firstCigarette: firstCigarette, smokingYears: smokingYears)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                print("서버 응답: \(response)")
                completion(response.status)
            }.store(in: &cancellables)
    }
    
    //흡연 정보 확인
    func read(completion: @escaping (Bool)->Void) {
        SmokingHabitService.shared.readSH(userId: userId, dailyCigarettes: dailyCigarettes, cigarettePrice: cigarettePrice, firstCigarette: firstCigarette, smokingYears: smokingYears)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                print("서버 응답: \(response)")
                completion(response.status)
            }.store(in: &cancellables)
    }
    
    //흡연 정보 수정
    func update(completion: @escaping (Bool)->Void) {
        SmokingHabitService.shared.updateSH(habit_id: habitId, userId: userId, dailyCigarettes: dailyCigarettes, cigarettePrice: cigarettePrice, firstCigarette: firstCigarette, smokingYears: smokingYears)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                print("서버 응답: \(response)")
                completion(response.status)
            }.store(in: &cancellables)
    }
}
