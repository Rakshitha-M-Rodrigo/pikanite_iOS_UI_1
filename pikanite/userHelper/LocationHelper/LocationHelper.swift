

import Foundation
import SwiftyJSON
import Alamofire

class LocationHelper: RequestHelper {
    
    static func updateUserLocation(latitiude: Double, longitude: Double, completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFErrors?) -> ())) {
        
        let params = ["latitude":latitiude , "longitude":longitude]
        Alamofire.request(RequestUrls.locationUpdatenUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                let resultJSON = JSON(dataResponse.result.value!)
                
                if resultJSON["error"].stringValue  == "Unauthenticated." {
                    UserHelper.signOut()
                    return
                }
                
                completion(true, resultJSON, nil)
            } else {
                completion(false, nil, nil)
            }
        }
    }
}
