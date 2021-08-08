//
//  APIManager.swift
//  Penprnt
//
//  Created by Eslam Sebaie on 4/29/21.
//

import Alamofire
import SwiftyJSON
class APIManager {
    class func userRegister(name: String, emailNumber: String, address: String, dateOfBirth: String, gender: String, phoneNumber: String ,password: String, lat: String, lng: String, points: String,completion: @escaping(Result<SignUpResponse, Error>) -> Void) {
        request(APIRouter.userRegister(name, emailNumber, address, dateOfBirth, gender, phoneNumber ,password, lat, lng, points)) { (response) in
            completion(response)
        }
    }
    class func userLogin( email: String, password: String, completion: @escaping(Result<SignUpResponse, Error>) -> Void) {
        request(APIRouter.userLogin(email, password)) { (response) in
            completion(response)
        }
    }
    class func getCategories(vendorId: String, completion: @escaping(Result<CategoryResponse, Error>) -> Void ) {
        request(APIRouter.getCategories(vendorId)) { (response) in
            completion(response)
        }
    }
    class func getSubCategories(categoryId: String, completion: @escaping(Result<SubCatResponse, Error>) -> Void ) {
        request(APIRouter.getSubCategories(categoryId)) { (response) in
            completion(response)
        }
    }
    
    
    class func updateAddress(emailNumber: String, address: String, lat: String, lng: String ,completion: @escaping() -> Void ) {
        request1(APIRouter.updateAddress(emailNumber,address,lat,lng)) { (_,_) in
            completion()
        }
    }
    class func searchName(name: String,idSub: Int, completion: @escaping(Result<productResponse, Error>) -> Void ) {
        request(APIRouter.searchProduct(name,idSub)) { (response) in
            completion(response)
        }
    }
    class func updateImage(emailNumber: String, image: String ,completion: @escaping() -> Void ) {
        request1(APIRouter.updateImage(emailNumber,image)) { (_,_) in
            completion()
        }
    }
    class func updateProfile(emailNumber: String, name: String, phone: String, dateOfBirth: String , address: String, gender: String ,password: String, points: String,completion: @escaping() -> Void ) {
        request1(APIRouter.editProfile(emailNumber,name,phone,dateOfBirth, address, gender,password, points)) { (_,_) in
            completion()
        }
    }
    
    class func productsNew(id: Int, idSub: Int, idVendor: Int ,completion: @escaping(Result<productResponse, Error>) -> Void ) {
        request(APIRouter.productsNew(id,idSub,idVendor)) { (response) in
            completion(response)
        }
    }
    class func productsSale(idSub: Int, completion: @escaping(Result<MostProductResponse, Error>) -> Void ) {
        request(APIRouter.productsSale(idSub)) { (response) in
            completion(response)
        }
    }
    class func searchUser(emailNumber: String, completion: @escaping(Result<UserResponse, Error>) -> Void ) {
        request(APIRouter.searchUser(emailNumber)) { (response) in
            completion(response)
        }
    }
    class func sortProduct(id: Int, completion: @escaping(Result<productResponse, Error>) -> Void ) {
        request(APIRouter.filterAlph(id)) { (response) in
            completion(response)
        }
    }
    
    class func filterColorPrice(idSub: Int, color: String, price: String,completion: @escaping(Result<productResponse, Error>) -> Void ) {
        request(APIRouter.filterByPriceColor(idSub, color, price)) { (response) in
            completion(response)
        }
    }
    class func getAllStors(completion: @escaping(Result<StoreResponse, Error>) -> Void ) {
        request(APIRouter.getAllStors) { (response) in
            completion(response)
        }
    }
    class func postRate(emailNumber: String, star: String, comment: String, productId: Int, date: String,completion: @escaping() -> Void ) {
        request1(APIRouter.postRate(emailNumber,star,comment,productId,date)) { (_,_) in
            completion()
        }
    }
    
    class func getRate(productId: Int, completion: @escaping(Result<RateResponse, Error>) -> Void ) {
        request(APIRouter.getRate(productId)) { (response) in
            completion(response)
        }
    }
    
    class func makeFavorite(emailNumber: String, id: Int , completion: @escaping() -> Void ) {
        request1(APIRouter.makeFavorite(emailNumber,id)) { (_,_) in
            completion()
        }
    }
    
    class func setCart(emailNumber: String, product_id: Int, name: String, price: String, quantity: String, Color: String, size: String, image: String,completion: @escaping() -> Void ) {
        request1(APIRouter.setCart(emailNumber,product_id,name,price,quantity,Color,size,image)) { (_,_) in
            completion()
        }
    }
    class func getCart(emailNumber: String, completion: @escaping(Result<CartResponse, Error>) -> Void ) {
        request(APIRouter.getCart(emailNumber)) { (response) in
            completion(response)
        }
    }
    class func getFavorite(emailNumber: String, completion: @escaping(Result<FavoriteResponse, Error>) -> Void ) {
        request(APIRouter.getFavorite(emailNumber)) { (response) in
            completion(response)
        }
    }
    class func deleteFavorite(id: Int, completion: @escaping() -> Void ) {
        request1(APIRouter.deleteFavorite(id)) { (_,_) in
            completion()
        }
    }
    class func deleteCart(id: Int, completion: @escaping() -> Void ) {
        request1(APIRouter.deleteCart(id)) { (_,_) in
            completion()
        }
    }
    class func setOrder(emailNumber: String, orderDate: String, totalPrice: String, productId: [Int], price: [String], quantity: [String], Color: [String], size: [String], name: [String], image: [String], completion: @escaping() -> Void ) {
        request1(APIRouter.setOrder(emailNumber, orderDate, totalPrice, productId, price, quantity, Color, size, name, image)) { (_,_) in
            completion()
        }
    }
    class func getOrder(emailNumber: String, completion: @escaping(Result<OrderResponse, Error>) -> Void ) {
        request(APIRouter.getOrder(emailNumber)) { (response) in
            completion(response)
        }
    }
    class func getOrderDetails(id: Int, completion: @escaping(Result<OrderDetailsResponse, Error>) -> Void ) {
        request(APIRouter.getOrderDetails(id)) { (response) in
            completion(response)
        }
    }
    class func uploadPhoto(image: UIImage, completion: @escaping (_ error: Error?, _ upImage: uploadImage?)-> Void){
        
        AF.upload(multipartFormData: { (form: MultipartFormData) in
            
            if let data = image.jpegData(compressionQuality: 0.75) {
                form.append(data, withName: "storeFile", fileName: "storeFile.jpeg", mimeType: "storeFile/jpeg")
            }
        }, to: "http://penprnt.com/penprnt/api/uploadImage", usingThreshold: MultipartFormData.encodingMemoryThreshold, method: .post, headers: nil).response {
            response in
            guard response.error == nil else {
                print(response.error!)
                
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
         
                
                let decoder = JSONDecoder()
                let img = try decoder.decode(uploadImage.self, from: data)
                
                completion(nil, img)
            } catch let error {
                completion(response.error, nil)
            }
        }
    }
    
}

extension APIManager{
    
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        .responseJSON { response in
            print(response)
        }
    }
    private static func request1(_ urlConvertible: URLRequestConvertible, completion:  @escaping (_ error: Error?,_ data: Any) -> ()) {
        
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).response { (response: AFDataResponse) in
            print("ok1")
        }
        .responseJSON { response in
            print(response)
            completion(nil, response)
        }
    }
}

