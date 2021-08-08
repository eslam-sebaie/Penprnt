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
    case getCategories(_ vendorId: String)
    case getSubCategories(_ categoryId: String)
    case updateAddress(_ emailNumber: String, _ address: String, _ lat: String, _ lng: String)
    case searchProduct(_ name: String, _ idSub: Int)
    case updateImage(_ emailNumber: String, _ image: String)
    case editProfile(_ emailNumber: String, _ name: String, _ phone: String, _ dateOfBirth: String, _ address: String, _ gender: String,_ password: String, _ points: String)
    case productsNew(_ id: Int, _ idSub: Int, _ idVendor: Int)
    case productsSale(_ idSub: Int)
    case searchUser(_ emailNumber: String)
    case filterAlph(_ id: Int)
    case filterByPriceColor(_ idSub: Int, _ color: String, _ price: String)
    case getAllStors
    case postRate(_ emailNumber: String, _ star: String, _ comment: String, _ productId: Int, _ date: String)
    case getRate(_ productId: Int)
    case makeFavorite(_ emailNumber: String, _ id: Int)
    case getFavorite(_ emailNumber: String)
    case setCart(_ emailNumber: String, _ product_id: Int, _ name: String, _ price: String, _ quantity: String, _ Color: String, _ size: String, _ image: String, _ note: String)
    case getCart(_ emailNumber: String)
    case deleteFavorite(_ id: Int)
    case deleteCart(_ id: Int)
    case setOrder(_ emailNumber: String, _ orderDate: String, _ totalPrice: String, _ productId: [Int], _ price: [String], _ quantity: [String], _ Color: [String], _ size: [String], _ name: [String], _ image: [String])
    case getOrder(_ emailNumber: String)
    case getOrderDetails(_ id: Int)
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .userRegister, .userLogin, .updateAddress, .updateImage, .editProfile, .postRate, .makeFavorite, .setCart, .setOrder:
            return .post
        case .getCategories, .getSubCategories ,.searchProduct, .productsNew, .productsSale, .searchUser, .filterAlph, .filterByPriceColor, .getAllStors, .getRate, .getCart, .getFavorite, .getOrder, .getOrderDetails:
            return .get
        case .deleteFavorite, .deleteCart:
            return .delete
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
        
        case .getCategories(let vendorId):
            return ["vendorId": vendorId]
            
        case .getSubCategories(let categoryId):
            return ["categoryId": categoryId]
            
        case .updateAddress(let emailNumber ,let address, let lat , let lng):
            return [ParameterKeys.email: emailNumber,ParameterKeys.address: address, "lat": lat, "lng": lng]
        case .searchProduct(let name, let idSub):
            return ["name": name, "idSub": idSub]
        case .updateImage(let emailNumber, let image):
            return [ParameterKeys.email: emailNumber, "image": image]
        case .editProfile(let emailNumber, let name, let phone, let dateOfBirth,let address, let gender, let password, let points):
            return [ParameterKeys.email: emailNumber, ParameterKeys.name: name, ParameterKeys.phone: phone, ParameterKeys.dateOfBirth: dateOfBirth,ParameterKeys.address: address,ParameterKeys.gender: gender, ParameterKeys.password: password, "points": points ]
        case .productsNew(let id, let idSub, let idVendor):
            return ["id": id, "idSub": idSub, "idVendor": idVendor]
        case .productsSale(let idSub):
            return ["idSub": idSub]
        case .searchUser(let emailNumber):
            return [ParameterKeys.email: emailNumber]
        case .filterAlph(let id):
            return ["id": id]
        case .filterByPriceColor(let idSub, let color, let price):
            return ["idSub": idSub, "color": color, "price": price]
        case .postRate(let emailNumber, let star,let comment,let productId,let date):
            return ["emailNumber": emailNumber, "star": star, "comment": comment,"productId": productId, "date":date]
        case .getRate(let productId):
            return ["productId": productId]
        case .makeFavorite(let emailNumber, let id):
            return ["emailNumber": emailNumber, "id": id]
        case .setCart(let emailNumber, let product_id,let name,let price,let quantity,let Color,let size,let image, let note):
            return ["emailNumber": emailNumber, "product_id": product_id, "name": name, "price": price, "quantity": quantity, "Color": Color, "size": size, "image": image, "note": note]
        case .getCart(let emailNumber):
            return [ParameterKeys.email: emailNumber]
        case .getFavorite(let emailNumber):
            return [ParameterKeys.email: emailNumber]
        case .deleteFavorite(let id):
            return ["id": id]
        case .deleteCart(let id):
            return ["id": id]
        case .setOrder(let emailNumber, let orderDate, let totalPrice, let productId, let price, let quantity, let Color, let size, let name, let image):
            return [ParameterKeys.email: emailNumber, "orderDate": orderDate, "totalPrice": totalPrice, "productId": productId, "price": price, "quantity": quantity, "Color": Color, "size": size, "name": name, "image": image]
        case .getOrder(let emailNumber):
            return [ParameterKeys.email: emailNumber]
        case .getOrderDetails(let id):
            return ["id": id]
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
        case .getSubCategories:
            return URLs.subCategory
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
        case .getAllStors:
            return URLs.alltStoreWithCount
        case .postRate:
            return URLs.rate
        case .getRate:
            return URLs.rate
        case .makeFavorite:
            return URLs.favorite
        case .getFavorite:
            return URLs.favorite
        case .setCart:
            return URLs.cart
        case .getCart:
            return URLs.cart
        case .deleteFavorite:
            return URLs.favorite
        case .deleteCart:
            return URLs.cart
        case .setOrder:
            return URLs.order
        case .getOrder:
            return URLs.order
        case .getOrderDetails:
            return URLs.orderDetails
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

