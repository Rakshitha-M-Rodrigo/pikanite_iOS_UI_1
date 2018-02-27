

import Foundation
import SwiftyJSON
import Alamofire
import ObjectMapper

class PaymentHelper: RequestHelper {
    
//    static func getPaymentmethods(completion: @escaping ((_ isSuccess: Bool, _ response: [PaymentCard]?, _ error: AFErrors?) -> ())) {
//        Alamofire.request(RequestUrls.getPaymentMethods, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
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
//
//                    guard let notificationsString = resultJSON["content"]["payment_methods"].rawString() else {
//                        completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Please add a payment method to continue"))
//                        return
//                    }
//
//                    guard let cards = Mapper<PaymentCard>().mapArray(JSONString: notificationsString) else {
//                        completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: "Parse Error", message: "Couldn't parse payment methods"))
//                        return
//                    }
//                    completion(true, cards, nil)
//                    return
//                } else {
//
//                    guard let messageCode = resultJSON["message_code"].string, let messageText = resultJSON["text"].string else {
//                        let errors = RequestHelper.getDefaultApiErrors()
//                        completion(false, nil, errors)
//                        return
//                    }
//                    completion(false, nil, RequestHelper.getDefaultApiErrors(errorId: messageCode, message: messageText))
//                }
//            } else {
//                completion(false, nil, RequestHelper.getDefaultApiErrors())
//            }
//        }
//    }
    
    static func addPayment (paymentnonce: String, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let url = "\(RequestUrls.AddPaymentMethod)/\(paymentnonce)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
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
}
