//
//  MotivationViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-19: Motivation ViewModel 코드 생성
//  Edited by 한유진 on 2024-07-28: Refactor
//

import Foundation
import SwiftUI
import Combine

class MotivationViewModel: ObservableObject {
    @Published var userId = 0
    @Published var motivationId = 0
    @Published var userMotivationId = 0
    
    private var cancellables = Set<AnyCancellable>()
}
