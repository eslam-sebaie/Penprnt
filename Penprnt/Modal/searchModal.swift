//
//  searchModal.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/24/21.
//

import Foundation
struct searchResponse: Codable {
    let data: [searchInfo]?
    let message: String
}

// MARK: - Datum
struct searchInfo: Codable {
    let id: Int?
    let image: String?
    let name, datumDescription, itemNo, brandName: String?
    let price, wholeSale, quantity: String?
    let size: [String]?
    let barCode, date: String?
    let design: String?
    let productColor: [String]?
    let totalRate: String?
    let totalCountUser: String?
    let isActive: Bool?
    let vendorID, categoryID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case datumDescription = "description"
        case itemNo, brandName, price, wholeSale, quantity, size, barCode, date, design, productColor,totalRate,totalCountUser, isActive
        case vendorID = "vendorId"
        case categoryID = "categoryId"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct FilterResponse: Codable {
    let data: [FilterInfo]
    let message: String
}

// MARK: - Datum
struct FilterInfo: Codable {
    let id: Int?
    let image: String?
    let name, datumDescription, itemNo, brandName: String?
    let price, wholeSale, quantity: String?
    let size: [String]?
    let barCode, date: String?
    let design: String?
    let totalRate: String?
    let totalCountUser: String?
    let productColor: [String]?
   
    let isActive: Bool?
    let vendorID, categoryID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case datumDescription = "description"
        case itemNo, brandName, price, wholeSale, quantity, size, barCode, date, design, productColor,isActive,totalRate, totalCountUser
        case vendorID = "vendorId"
        case categoryID = "categoryId"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
