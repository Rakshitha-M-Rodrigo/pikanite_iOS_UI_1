

import Foundation
import SwiftyJSON
import Alamofire
import ObjectMapper

class UserHelper: RequestHelper {
    
    
    
    static func updateUser(params: [String: Any], completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        Alamofire.request(RequestUrls.memberUpdateUrl, method: .put, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                if resultJSON["success"].boolValue {
                    completion(true, resultJSON, nil)
                    return
                }else{
                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors())
                        return
                    }
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                    return
                }
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    

    static func changePassword(params: [String: Any], completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        Alamofire.request(RequestUrls.passwordChangeUrl, method: .put, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                if resultJSON["success"].boolValue {
                    completion(true, resultJSON, nil)
                    return
                }else{
                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors())
                        return
                    }
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    
    static func forgotPassword(email: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["member_email": email]
        
        Alamofire.request(RequestUrls.forgotPasswordUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                if resultJSON["success"].boolValue {
                    completion(true, resultJSON, nil)
                    return
                }else{
                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors())
                        return
                    }
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    
    static func forgotPassword(email: String, password: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["member_email": email,
                      "member_password": password]
        
        Alamofire.request(RequestUrls.loginUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                if resultJSON["success"].boolValue {
                    completion(true, resultJSON, nil)
                    return
                }else{
                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors())
                        return
                    }
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    
    static func getProfile(completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        Alamofire.request(RequestUrls.getProfileUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                if resultJSON["success"].boolValue {
                    guard let profileString :JSON  = resultJSON["content"]["profile"] else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                        return
                    }
                    completion(true, profileString, nil)
                    return
                }else{
                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors())
                        return
                    }
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    
    static func getProfile(latitude: Double, longitude:Double, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["longitude": longitude, "latitude":latitude]
        
        Alamofire.request(RequestUrls.locationUpdatenUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                
                if resultJSON["success"].boolValue {
                    completion(true, resultJSON, nil)
                    return
                }else{
                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                        let errors = RequestHelper.getDefaultApiErrors()
                        completion(false, nil, errors)
                        return
                    }
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                    return
                }
                
            } else {
                completion(false, nil, nil)
            }
        }
    }
    
    //get user purchase history
//    static func getPurchaseHistory(completion: @escaping ((_ isSuccess: Bool, _ response: [PurchaseHistory]?, _ error: AFErrors?) -> ())) {
//
//        let url = RequestUrls.getPurchaseHistoryUrl
//
//
//        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
//            if dataResponse.result.isSuccess {
//                let resultJSON = JSON(dataResponse.result.value!)
//
//                if resultJSON["error"].stringValue  == "Unauthenticated." {
//                    self.signOut()
//                    return
//                }
//
//                if resultJSON["success"].boolValue {
//
//                    guard let purchaseHistoryString = resultJSON["content"]["purchasing_history"].rawString() else {
//                        completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
//                        return
//                    }
//
//                    guard let purchaseHistorylist = Mapper<PurchaseHistory>().mapArray(JSONString: purchaseHistoryString) else {
//                        completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Couldn't parse notifications"))
//                        return
//                    }
//
//                    completion(true, purchaseHistorylist, nil)
//                    return
//
//                }else{
//                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
//                        let errors = RequestHelper.getDefaultApiErrors()
//                        completion(false, nil, errors)
//                        return
//                    }
//                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
//                    return
//                }
//
//            } else {
//                completion(false, nil, nil)
//                return
//            }
//        }
//    }
    
    
    //get bt token
    static func fetchBTToken(completion: @escaping ((_ isSuccess: Bool, _ tokenString: String?, _ error: AFErrors?) -> ())) {
        Alamofire.request(RequestUrls.getBtToken, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                if resultJSON["success"].boolValue {
                    
                    guard let tokenText = resultJSON["content"]["token"].string else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content / token object not found"))
                        return
                    }
                    completion(true, tokenText, nil)
                    return
                } else {
                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                        let errors = RequestHelper.getDefaultApiErrors()
                        completion(false, nil, errors)
                        return
                    }
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                }
            } else {
                completion(false, nil, nil)
            }
        }
    }
    
    
    
    
    static func getUserPhotoGalleryUpdated(from: Int, to: Int, completion: @escaping ((_ isSuccess: Bool, _ response: [JSON]?, _ error: AFErrors?) -> ())) {
        
        let url = RequestUrls.getUserGallery + "/\(from)" + "/\(to)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                if resultJSON["success"].boolValue {
                    
                    guard let memberImages = resultJSON["content"]["member_images"].array else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                        return
                    }
                    completion(true, memberImages, nil)
                    return
                } else {
                    
                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors())
                        return
                    }
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                }

            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
            }
        }
    }
    
    static func changeProfilePic(imageData: Data?, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        //let params = ["profile_picture": imageData]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = imageData{
                multipartFormData.append(data, withName: "profile_picture", fileName: "image.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: RequestUrls.profilePicChangeUrl, method: .post, headers: getCommonHeaders(withAuth: true)) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
//                    print("Succesfully uploaded")
                    if response.error != nil {
                        completion(false, nil, nil)
                        return
                    }
                    let resultJSON = JSON(response.result.value!)
                    
                    if resultJSON["error"].stringValue  == "Unauthenticated." {
                        self.signOut()
                        return
                    }
                    
                    if resultJSON["success"].boolValue {
                        completion(true, resultJSON, nil)
                        return
                    }else{
                        guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                            let errors = RequestHelper.getDefaultApiErrors()
                            completion(false, nil, errors)
                            return
                        }
                        completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                        return
                    }
                    
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completion(false, nil, nil)
            }
        }
    }
    
    
    
    static func deleteImage (imageId: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let url = "\(RequestUrls.deleteUserImages)/\(imageId)"
        Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                if resultJSON["success"].boolValue {
                    completion(true, resultJSON, nil)
                    return
                }else{
                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors())
                        return
                    }
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
            }
        }
    }
    
//    static func savePushToken (token: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
//
//        let params = ["device_type": "IOS",
//                      "token": token]
//        Alamofire.request(RequestUrls.savePushToken , method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
//            if dataResponse.result.isSuccess {
//                let resultJSON = JSON(dataResponse.result.value!)
//                completion(true, resultJSON, nil)
//            } else {
//                completion(false, nil, nil)
//            }
//        }
//    }
    
    static func uploadUserImage(imageData: Data?, eventId: String = "0", completion: @escaping ((_ isSuccess: Bool, _ response: Any?, _ isCompleted: Bool, _ percentage: Bool, _ error: AFErrors?) -> ())) {
        
        let params = ["event_id": eventId] as [String: Any]
        var uploadRequest: Request?
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let data = imageData{
                multipartFormData.append(data, withName: "event_image", fileName: "image.png", mimeType: "image/png")
            }
            if imageData == nil {
                uploadRequest?.cancel()
                uploadRequest = nil
            }
            
            for (key, value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, usingThreshold: UInt64.init(), to: RequestUrls.eventImageUploadUrl, method: .post,headers: getCommonHeaders(withAuth: true)) { (result) in
            switch result{
            case .success(let upload, _, _):
                uploadRequest = upload
                upload.uploadProgress(closure: { (progress) in
                    completion(true, progress, false , true,  nil)
                })
                
                upload.responseJSON { response in
                    if response.result.isSuccess{
                        let responseJSON = JSON(response.result.value!)
                        
                        if responseJSON["error"].stringValue  == "Unauthenticated." {
                            self.signOut()
                            return
                        }
                        
                        completion(true, responseJSON, true , false,  nil)
                    } else {
                        if let error = response.result.error {
                            let valError = AFValidationError(id: "error", message: error.localizedDescription)
                            let afError = AFErrors(errors: [valError])
                            completion(false, nil, true , false,  afError)
                        } else {
                            completion(false, nil, true , false,  nil)
                        }
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completion(false, nil, true , false,  nil)
            }
        }
    }
    
    
    
    static func getOffers(completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        Alamofire.request(RequestUrls.offers, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                
                if let offerString: JSON  = resultJSON["content"]{
                    completion(true, offerString, nil)
                    return
                } else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                        return
                }
                
                
                
                    guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["success"].string else {
                        completion(false, nil, RequestHelper.getDefaultApiErrors())
                        return
                }
                
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    static func getHotelProfile(hotelID: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let url = RequestUrls.hotelProfile + "/\(hotelID)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                
                if let hotelProfileString:JSON  = resultJSON{
                    completion(true, hotelProfileString, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["success"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
            }
        }
    }

    static func checkUser(email: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["Email": email]
        
        Alamofire.request(RequestUrls.checkUser, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                print(resultJSON)
                print(resultJSON as Any)
                if let userStatus:JSON  = resultJSON{
                    completion(true, userStatus, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["details"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }

    
    static func registerNewUser(email: String, name: String, password: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["Email": email, "Name": name, "Password": password, "UserType": "standard", "Role": "iOS-User" ]
        
        Alamofire.request(RequestUrls.registrationUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                print(resultJSON as Any)
                if let userStatus:JSON  = resultJSON{
                    completion(true, userStatus, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["details"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    
    static func loginSocialMediaUser(email: String, name: String, socialLoginId: String, userType: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["Email": email, "Name": name, "SocialLoginId": socialLoginId, "UserType": userType, "Role": "standard"]
        
        Alamofire.request(RequestUrls.socialMediaRegister, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                print(resultJSON as Any)
                if let userStatus:JSON  = resultJSON{
                    completion(true, userStatus, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["details"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    static func loginUser(email: String, password: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["Email": email, "Password": password]
        
        Alamofire.request(RequestUrls.loginUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                print(resultJSON)
                print(resultJSON as Any)
                if let userData:JSON  = resultJSON{
                    completion(true, userData, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["details"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    
    static func getbookings(userID: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let url = RequestUrls.getBookings + "/\(userID)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                print(resultJSON)
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                
                if let bookings:JSON  = resultJSON{
                    completion(true, bookings, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["success"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
            }
        }
    }
    
    
    static func getAllBookings(completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let url = RequestUrls.getAllBookings
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                print(resultJSON)
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                
                if let bookings:JSON  = resultJSON{
                    completion(true, bookings, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["success"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
            }
        }
    }
    
    
    static func bookHotel(userEmail: String, HotelEmail: String, RoomCount: String, recordedDate: String, promoCode: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["UserEmail": userEmail, "HotelEmail": HotelEmail, "NumberOfRooms": RoomCount, "RecordedDate": recordedDate, "PromoCode": promoCode]
        
        Alamofire.request(RequestUrls.bookHotel, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                print(resultJSON)
                print(resultJSON as Any)
                if let BookingInfo:JSON  = resultJSON{
                    completion(true, BookingInfo, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["details"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    
    static func updateUserPassword(userEmail: String, oldPassword: String, newPassword: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["Email": userEmail, "OldPassword": oldPassword, "NewPassword": newPassword]
        
        Alamofire.request(RequestUrls.updatePassword, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                print(resultJSON)
                print(resultJSON as Any)
                if let BookingInfo:JSON  = resultJSON{
                    completion(true, BookingInfo, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["details"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    static func updateUserProfile(userID: String, birthDay: String, name: String, contactNumber: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["UserId": userID, "BirthDay": birthDay, "Name": name, "ContactNumber": contactNumber]
        
        Alamofire.request(RequestUrls.userProfileUpdateUrl, method: .put, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                print(resultJSON)
                print(resultJSON as Any)
                if let updateInfo:JSON  = resultJSON{
                    completion(true, updateInfo, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["details"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    static func getServerCurrentTime(completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let url = RequestUrls.getServerCurrentTime
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                print(resultJSON)
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                
                if let currentTimeJson:JSON  = resultJSON{
                    completion(true, currentTimeJson, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["success"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
            }
        }
    }
    
    static func checkPromoCode(promoCode: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        
        let url = RequestUrls.checkPromoCode + "/\(promoCode)"
        print("promo code \(promoCode)")
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                print(resultJSON)
                print(resultJSON as Any)
                if let updateInfo:JSON  = resultJSON{
                    completion(true, updateInfo, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                guard let messageCode = resultJSON["message"].string, let amount = resultJSON["amount"].double, let percentage = resultJSON["percentage"].double else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
                return
            }
        }
    }
    
    static func getHotelProfileInfo(hotelID: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let url = RequestUrls.hotelProfileInfo + "/\(hotelID)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    self.signOut()
                    return
                }
                
                
                if let hotelProfileString:JSON  = resultJSON{
                    completion(true, hotelProfileString, nil)
                    return
                } else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Content object not found"))
                    return
                }
                
                
                
                guard let messageCode = resultJSON["message"].string, let messageText = resultJSON["success"].string else {
                    completion(false, nil, RequestHelper.getDefaultApiErrors())
                    return
                }
                
                
            } else {
                completion(false, nil, RequestHelper.getDefaultApiErrors())
            }
        }
    }
}
