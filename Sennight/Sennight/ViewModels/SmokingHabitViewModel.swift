//
//  SmokingHabitViewModel.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 한유진 on 2024-07-27: getSmokingHabit() 추가
//

import Combine
import SwiftUI

class SmokingHabitViewModel: ObservableObject {
    @Published var habitID = 0
    @Published var dailyCigarettes = 0
    @Published var cigarettePrice: Double = 0
    @Published var firstCigarette = ""
    @Published var smokingYears = 0
    
    @Published var smokingHabit: SmokingHabit?
    
    private var cancellables = Set<AnyCancellable>()
    
    func createSmokingHabit(completionHandler: @escaping (Bool)->Void) {
        SmokingHabitService.shared.createSmokingHabit(dailyCigarettes: dailyCigarettes, cigarettePrice: cigarettePrice, firstCigarette: firstCigarette, smokingYears: smokingYears)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completionHandler(response.status)
            }.store(in: &cancellables)
    }
    
    func getSmokingHabit() {
        SmokingHabitService.shared.getSmokingHabit()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                self.smokingHabit = response.data
            }.store(in: &cancellables)
    }
}
