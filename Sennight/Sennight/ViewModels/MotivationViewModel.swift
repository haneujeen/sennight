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
    @Published var userMotivation: UserMotivation?
    @Published var motivationDataID = 0
    @Published var isLoading = false
    @Published var showError = false
    
    private var cancellables = Set<AnyCancellable>()
    
    // 금연 동기 등록
    func getMotivation() {
        guard !isLoading else { return }  // 이미 로딩 중이면 중복 호출 방지
        
        isLoading = true
        showError = false
        
        MotivationService.shared.read()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.showError = true
                }
            } receiveValue: { [weak self] response in
                print("서버응답: \(response)")
                if let data = response.data {
                    self?.userMotivation = data
                    self?.motivationDataID = data.id
                }
            }
            .store(in: &cancellables)
    }
}
