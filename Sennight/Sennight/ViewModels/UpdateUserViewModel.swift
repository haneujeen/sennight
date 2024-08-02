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
    @Published var appleID: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func updatePassword(completionHandler: @escaping (UserResponse) -> Void){
        UserService.shared.updatePassword(name: nil, password: password, photoFilename: nil)
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
    
    func updateWithAppleID(completionHandler: @escaping (UserResponse) -> Void){
        guard let appleID else { return }
        UserService.shared.updateWithAppleID(appleID: appleID)
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
