

import Foundation
import SwiftyJSON
import Alamofire
import ObjectMapper

class NotificationHelper: RequestHelper {
    
    
    
    //seen notification
//    static func seenNotifications(notificationID: Int , completion: @escaping ((_ isSuccess: Bool, _ response: [Json]?, _ error: AFErrors?) -> ())) {
//        
//        let url = RequestUrls.notificationsseenUrl + "/\(notificationID)"
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
//                    completion(true, resultJSON["content"].arrayObject as! [Json], nil)
//                    
//                } else {
//                    
//                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
//                        completion(false, nil, RequestHelper.getDefaultApiErrors())
//                        return
//                    }
//                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
//                }
//            } else {
//                completion(false, nil, RequestHelper.getDefaultApiErrors())
//            }
//        }
//    }
//    
//    
//    
//    
//    static func completeActivity(params: [String: Any], completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
//        
//        Alamofire.request(RequestUrls.completeActivityUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
//            if dataResponse.result.isSuccess {
//                let resultJSON = JSON(dataResponse.result.value!)
//                
//                if resultJSON["error"].stringValue  == "Unauthenticated." {
//                    self.signOut()
//                    return
//                }
//                
//                if resultJSON["success"].boolValue {
//                    completion(true, resultJSON, nil)
//                    return
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
//                completion(false, nil, RequestHelper.getDefaultApiErrors())
//            }
//        }
//    }
//    
//    static func redeemReward (reward_id: Int, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
//        
//        let params = ["reward_id": reward_id]
//        
//        Alamofire.request(RequestUrls.redeemRewardUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
//            
//            if dataResponse.result.isSuccess {
//                
//                let resultJSON = JSON(dataResponse.result.value!)
//                
//                if resultJSON["error"].stringValue  == "Unauthenticated." {
//                    self.signOut()
//                    return
//                }
//                
//                if resultJSON["success"].boolValue {
//                    completion(true, resultJSON, nil)
//                    return
//                } else {
//                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
//                        completion(false, nil, RequestHelper.getDefaultApiErrors())
//                        return
//                    }
//                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
//                }
//            } else {
//                completion(false, nil, RequestHelper.getDefaultApiErrors())
//            }
//        }
//    }
    
    
    
    
    
}
