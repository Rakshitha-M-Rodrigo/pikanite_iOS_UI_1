

import Foundation
import SwiftyJSON

class TokenUpdateHelper {
    
    static func fetchClientToken(){
        
        UserHelper.fetchBTToken { (status, tokenText, errors) in
            if status && tokenText != nil {
                RequestHelper.setBTClientToken(token: tokenText!)
            } else {
                
            }
        }
    }

}
