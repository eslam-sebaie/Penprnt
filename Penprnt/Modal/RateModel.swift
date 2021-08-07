//
//  RateModel.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/7/21.
//

import Foundation
struct RateResponse: Codable {
    let data: [RateInfo]?
    let message: String?
}

// MARK: - Datum
struct RateInfo: Codable {
    let id: Int
    let star, comment, date, productID: String?
    let userID: String?
    let product: Product?
    let user: RateUser?

    enum CodingKeys: String, CodingKey {
        case id, star, comment, date
        case productID = "product_id"
        case userID = "user_id"
        case product, user
    }
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let image: String?
    let name, productDescription, itemNo, brandName: String?
    let price, wholeSale, quantity: String?
    let size: [String]?
    let barCode, date: String?
    let design: String?
    let productColor: [String]?
    let totalRate, totalCountUser: String?
    let isActive: Bool?
    let vendorID, categoryID, subcategoryID, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case productDescription = "description"
        case itemNo, brandName, price, wholeSale, quantity, size, barCode, date, design, productColor, totalRate, totalCountUser, isActive
        case vendorID = "vendorId"
        case categoryID = "categoryId"
        case subcategoryID = "subcategoryId"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - User
struct RateUser: Codable {
    let id: Int?
    let emailNumber, password, name: String?
    let birthDate, phone, gender, address: String?
    let lat, lng, points, image: String?
    enum CodingKeys: String, CodingKey {
        case id, emailNumber, password,name,birthDate,phone,gender,address,lat,lng,points,image
    }
}
