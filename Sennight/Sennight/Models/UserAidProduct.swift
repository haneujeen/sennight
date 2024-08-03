//
//  UserAidProduct.swift
//  Sennight
//
//  Created by 한유진 on 7/27/24.
//

import Foundation
/**
 {
     "user_id": 1,
     "aid_product_id": 7,
     "start_date": "2023-01-01"
 }
 
 {
     "status": true,
     "detail": "User's aid product added successfully",
     "data": {
         "id": 8,
         "aid_product_id": 7,
         "user_id": 1,
         "start_date": "2023-01-01",
         "end_date": null
     }
 }
 */
struct UserAidProductRequest: Codable {
    let userID: Int
    let aidProductID: Int
    let startDate: String
   
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case aidProductID = "aid_product_id"
        case startDate = "start_date"
    }
}

struct UserAidProduct: Codable {
    let ID: Int
    let userID: Int
    let aidProductID: Int
    let startDate: String
    
    enum CodingKeys: String, CodingKey {
        case ID = "id"
        case userID = "user_id"
        case aidProductID = "aid_product_id"
        case startDate = "start_date"
    }
}

struct UserAidProductResponse: Codable {
    let status : Bool
    let detail : String
    let data : UserAidProduct
}

struct UserAidProductListResponse: Codable {
    let status : Bool
    let detail : String
    let data : [UserAidProduct]?
}
