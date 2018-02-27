

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class RegistrationHelper: RequestHelper {
    
    static func registerUser(params: [String: Any], completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        Alamofire.request(RequestUrls.registrationUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders(withAuth: false)).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
//                completion(true, resultJSON, nil)
                
                if resultJSON["success"].boolValue {
                    completion(true, resultJSON["content"], nil)
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
    
    
    static func signIn (email: String, password: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
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
                    completion(true, resultJSON["content"], nil)
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

}
