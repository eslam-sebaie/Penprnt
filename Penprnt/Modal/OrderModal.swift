//
//  OrderModal.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 8/8/21.
//

import Foundation
struct OrderResponse: Codable {
    let data: [OrderInfo]?
    let message: String
}

// MARK: - Datum
struct OrderInfo: Codable {
    let id: Int?
    let orderNumber, orderDate, orderStatus, totalPrice: String?
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case id, orderNumber, orderDate, orderStatus, totalPrice
        case userID = "userId"
    }
}
struct OrderDetailsResponse: Codable {
    let data: [OrderDetailsInfo]?
    let message: String
}

// MARK: - Datum
struct OrderDetailsInfo: Codable {
    let id: Int
    let productID, orderID, price, quantity: String?
    let color, size, name: String?
    let image: String?
    let order: Order?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case orderID = "order_id"
        case price, quantity
        case color = "Color"
        case size, name, image, order
    }
}

// MARK: - Order
struct Order: Codable {
    let id: Int
    let orderNumber, orderDate, orderStatus, totalPrice: String?
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case id, orderNumber, orderDate, orderStatus, totalPrice
        case userID = "userId"
    }
}
