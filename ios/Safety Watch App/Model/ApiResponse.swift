//
//  ApiResponse.swift
//  SampleApp Watch App
//
//  Created by Mobilions iOS on 09/09/24.
//

import Foundation

struct APIResponse: Codable {
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
}
