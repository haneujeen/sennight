//
//  UpdateUserViewModel.swift
//  Sennight
//
//  Created by 한유진 on 7/18/24.
//

import Combine

class UpdateUserViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func update(completionHandler: @escaping (UserResponse) -> Void){
        UserService.shared.updateUser(name: nil, password: self.password, photoFilename: nil)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completionHandler(response)
            }
            .store(in: &cancellables)
    }
}
