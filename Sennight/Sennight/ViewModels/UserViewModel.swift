//
//  UserViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import Foundation
import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var password : String = "1234"
    @Published var userName : String = "sample@naver.com"
    
    private var cancellable = Set<AnyCancellable>
}

