//
//  APIRouter.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // The endpoint name
    // MARK:- Registration
    case userRegister(_ name: String,_ emailNumber: String, _ address: String,_ dateOfBirth: String, _ gender: String, _ phoneNumber: String ,_ password: String, _ lat: String, _ lng: String, _ points: String)
    case userLogin(_ emailNumber: String,_ password: String)
    case getCategories
    case updateAddress(_ emailNumber: String, _ address: String, _ lat: String, _ lng: String)
    case searchProduct(_ name: String)
    case updateImage(_ emailNumber: String, _ image: String)
    case editProfile(_ emailNumber: String, _ name: String, _ phone: String, _ dateOfBirth: String, _ address: String, _ gender: String,_ password: String, _ points: String)
    case productsNew(_ id: Int)
    case productsSale(_ id: Int)
    case searchUser(_ emailNumber: String)
    case filterAlph(_ id: Int)
    case filterByPriceColor(_ id: Int, _ productColor: [String], _ price: String)
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .userRegister, .userLogin, .updateAddress, .updateImage, .editProfile:
            return .post
        case .getCategories, .searchProduct, .productsNew, .productsSale, .searchUser, .filterAlph, .filterByPriceColor:
            return .get
        default:
            return .delete
        }
        
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        // MARK: - registerParameters
        case .userRegister(let name, let emailNumber, let address, let dateOfBirth , let gender, let phoneNumber ,let password, let lat, let lng, let points):
            return [ParameterKeys.name: name, ParameterKeys.email: emailNumber, ParameterKeys.address: address, ParameterKeys.dateOfBirth: dateOfBirth, ParameterKeys.gender: gender,ParameterKeys.phone: phoneNumber, ParameterKeys.password: password, "lat": lat, "lng": lng, "points": points]
        case .userLogin(let emailNumber, let password):
            return [ParameterKeys.email: emailNumber, ParameterKeys.password: password]
        case .updateAddress(let emailNumber ,let address, let lat , let lng):
            return [ParameterKeys.email: emailNumber,ParameterKeys.address: address, "lat": lat, "lng": lng]
        case .searchProduct(let name):
            return ["name": name]
        case .updateImage(let emailNumber, let image):
            return [ParameterKeys.email: emailNumber, "image": image]
        case .editProfile(let emailNumber, let name, let phone, let dateOfBirth,let address, let gender, let password, let points):
            return [ParameterKeys.email: emailNumber, ParameterKeys.name: name, ParameterKeys.phone: phone, ParameterKeys.dateOfBirth: dateOfBirth,ParameterKeys.address: address,ParameterKeys.gender: gender, ParameterKeys.password: password, "points": points ]
        case .productsNew(let id):
            return ["id": id]
        case .productsSale(let id):
            return ["id": id]
        case .searchUser(let emailNumber):
            return [ParameterKeys.email: emailNumber]
        case .filterAlph(let id):
            return ["id": id]
        case .filterByPriceColor(let id, let productColor, let price):
            return ["id": id, "productColor": productColor, "price": price]
        default:
            return nil
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        // MARK: - PathRegister
        case .userRegister:
            return URLs.userSignUp
        case .userLogin:
            return URLs.login
        case .getCategories:
            return URLs.createCategory
        case .updateAddress:
            return URLs.updateAddress
        case .searchProduct:
            return URLs.searchProduct
        case .updateImage:
            return URLs.updateImage
        case .editProfile:
            return URLs.editProfile
        case .productsNew:
            return URLs.productsNew
        case .productsSale:
            return URLs.productSale
        case .searchUser:
            return URLs.searchUser
        case .filterAlph:
            return URLs.filterAlph
        case .filterByPriceColor:
            return URLs.filterByPriceColor
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        print(urlRequest)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            default:
                return nil
            }
        }()
        
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
                
            default:
                return JSONEncoding.default
            }
        }()
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
        
            return jsonData
        } catch {
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}

