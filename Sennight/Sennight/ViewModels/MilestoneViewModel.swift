//
//  MilestoneViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-25: Milestone view model 정의
//

import Foundation
import SwiftUI
import Combine

class MilestoneViewModel: ObservableObject {
    @Published var data: [UserMilestone] = []
    @Published var userID = 0
  
    private var cancellables = Set<AnyCancellable>()
    
    func read() {
        print("마일스톤 뷰모델에서 마일스톤을 읽어오기")
        MilestoneService.shared.read()
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { data in
                self.data = data
            }
            .store(in: &cancellables)
    }
}
