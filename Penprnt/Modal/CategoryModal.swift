//
//  CategoryModal.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/3/21.
//

import Foundation
struct CategoryResponse: Codable {
    let data: [CategoryInfo]?
    let message: String
}

// MARK: - Datum
struct CategoryInfo: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let details: String?
    let vendorId: String?
    enum CodingKeys: String, CodingKey {
        case name, image, details, vendorId
        case id
    }
}

struct SubCatResponse: Codable {
    let data: [SubCatInfo]?
    let message: String
}

// MARK: - Datum
struct SubCatInfo: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let details: String?
    let categoryID: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image, details
        case categoryID = "categoryId"
    }
}
