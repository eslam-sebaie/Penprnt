//
//  AuthModal.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 5/3/21.
//

import Foundation
struct SignUpResponse: Codable {
    let data: SignUpInfo?
    let message, token: String
}

// MARK: - DataClass
struct SignUpInfo: Codable {
    let id: Int
     let emailNumber, password, name: String
     let birthDate, phone: String?
     let gender, address, lat, lng: String
     let points: String

    enum CodingKeys: String, CodingKey {
        case name, emailNumber, address, birthDate, gender, phone, password, lat, lng, points
        case id
    }
}
struct OrderStart: Codable {
    let data: Int
    let message: String
}
struct uploadImage: Decodable {
    var data: String
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct UserResponse: Codable {
    let data: [UserInfo]
    let message: String
}

// MARK: - Datum
struct UserInfo: Codable {
    let id: Int
    let emailNumber, password, name: String?
    let birthDate: String?
    let phone: String?
    let gender, address, lat, lng: String?
    let points: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case name, emailNumber, address, birthDate, gender, phone, password, lat, lng, points, image
        case id
    }
}
