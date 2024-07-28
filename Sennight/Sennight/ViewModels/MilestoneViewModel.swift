//
//  MilestoneViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import Foundation
import Combine

class MilestoneViewModel: ObservableObject {
    @Published var milestones: [UserMilestone] = []
    @Published var maxMilestoneID = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    func getAllMilestones() {
        MilestoneService.shared.getAllMilestones()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { milestones in
                self.milestones = milestones
            }
            .store(in: &cancellables)
    }
    
    func getMaxMilestoneID() {
        MilestoneService.shared.getMaxMilestoneID()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { maxMilestoneID in
                self.maxMilestoneID = maxMilestoneID
            }
            .store(in: &cancellables)
    }
}
