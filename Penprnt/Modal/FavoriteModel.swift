//
//  FavoriteModel.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/7/21.
//

import Foundation
struct FavoriteResponse: Codable {
    let data: [FavoriteInfo]?
    let message: String?
}

// MARK: - Datum
struct FavoriteInfo: Codable {
    let id: Int
    let productID, userID, createdAt, updatedAt: String
    let product: productInfo

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case product
    }
}


