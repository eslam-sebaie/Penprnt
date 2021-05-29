//
//  productModal.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/28/21.
//

import Foundation
struct productResponse: Codable {
    let data: [productInfo]
    let message: String
}

// MARK: - Datum
struct productInfo: Codable {
    let id: Int
    let image: String?
    let name, datumDescription, itemNo, brandName: String?
    let price, wholeSale, quantity: String?
    let size: [String?]
    let barCode: String?
    let date, design: String?
    let productColor: [String]?
    let isActive: Bool?
    let vendorID, categoryID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case datumDescription = "description"
        case itemNo, brandName, price, wholeSale, quantity, size, barCode, date, design, productColor, isActive
        case vendorID = "vendorId"
        case categoryID = "categoryId"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct MostProductResponse: Codable {
    let data: [MostProductInfo]
    let message: String
}

// MARK: - Datum
struct MostProductInfo: Codable {
    let productID: String
    let id: Int
    let products: Products

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case id, products
    }
}

// MARK: - Products
struct Products: Codable {
    let id: Int
    let image: String?
    let name, productsDescription, itemNo, brandName: String?
    let price, wholeSale, quantity: String?
    let size: [String?]
    let barCode: String?
    let date, design: String?
    let productColor: [String]?
    let isActive: Bool?
    let vendorID, categoryID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case productsDescription = "description"
        case itemNo, brandName, price, wholeSale, quantity, size, barCode, date, design, productColor, isActive
        case vendorID = "vendorId"
        case categoryID = "categoryId"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
