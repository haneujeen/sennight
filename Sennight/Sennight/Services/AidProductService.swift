//
//  FactorService.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-08-03: Updated AidProductService.swift
//

import Foundation
import Combine
import Alamofire

class AidProductService {
    static let shared = AidProductService()
    
    let HOST = Settings.shared.HOST
    
    func addAidProduct(aidProductID: Int, startDate: String) -> AnyPublisher<UserAidProductResponse, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let URL = "\(HOST)/user-aid-products"
        let parameters = UserAidProductRequest(userID: userID, aidProductID: aidProductID, startDate: startDate)
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(URL,
                          method: .post,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
        .publishDecodable(type: UserAidProductResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    func getAllAidProduct() -> AnyPublisher<UserAidProductListResponse, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let URL = "\(HOST)/user-aid-products/\(userID)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(URL,
                          method: .get,
                          headers: headers)
            .publishDecodable(type: UserAidProductListResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func deleteAidProduct(userAidProductID: Int) -> AnyPublisher<UserAidProductResponse, AFError> {
        guard let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let URL = "\(HOST)/user-aid-products/\(userAidProductID)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(URL,
                          method: .delete,
                          headers: headers)
            .publishDecodable(type: UserAidProductResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}

