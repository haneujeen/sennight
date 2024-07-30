//
//  Factor.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: Factor.swift 파일 이름 수정
//  Edited by 김소연 on 2024-07-27: AidProduct 모델 정의
//

import Foundation

//Read AidProduct 모델 구현
struct UserAidProductResponse: Codable {
    let status: Bool
    let detail: String
    let data: [UserAidProduct]
}

struct UserAidProduct: Codable, Identifiable {
    let id: Int
    let aidProductID: Int
    let userID: Int
    let startDate: String
    let endDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case aidProductID = "aid_product_id"
        case userID = "user_id"
        case endDate = "end_date"
        case startDate = "start_date"
    }
}
