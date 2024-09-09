//
//  UserModel.swift
//  SampleAppForWatchOs
//
//  Created by Mobilions iOS on 05/09/24.
//

import Foundation

//struct User: Codable {
//    let userId : Int?
//    let userName : String?
//    let userToken : String?
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case userId = "user_id"
//        case userName = "user_name"
//        case userToken = "user_token"
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
//        userName = try values.decodeIfPresent(String.self, forKey: .userName)
//        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
//    }
//    
//    
//}


struct User: Codable {
    let userId : Int?
    let userName : String?
    let userToken : String?
}
