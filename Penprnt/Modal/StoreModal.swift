//
//  StoreModal.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/6/21.
//

import Foundation
struct StoreResponse: Codable {
    let data: [StoreInfo]?
    let message: String?
}

// MARK: - Datum
struct StoreInfo: Codable {
    let id: Int?
    let storeName, emailNumber, landLine, storeLocation: String?
    let storeFile: String?
    let password: String
    let totalEarning: String?
    let totalProducts: [TotalProduct]?

    enum CodingKeys: String, CodingKey {
        case id, storeName, emailNumber, landLine, storeLocation, storeFile, password, totalEarning
        case totalProducts = "total_products"
    }
}

// MARK: - TotalProduct
struct TotalProduct: Codable {
    let vendorID, total: String?

    enum CodingKeys: String, CodingKey {
        case vendorID = "vendorId"
        case total
    }
}
