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
    enum CodingKeys: String, CodingKey {
        case name, image, details
        case id
    }
}
