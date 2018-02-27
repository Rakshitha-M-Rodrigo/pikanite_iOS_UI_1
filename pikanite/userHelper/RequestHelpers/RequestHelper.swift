

import Foundation
import UIKit
import Crashlytics
class RequestHelper {
    
    
    
    static func getCommonHeaders(withAuth: Bool = true) -> [String: String] {
        
        var headers = ["Accept": "application/json",
                       "Content-Type": "application/json",
                       "x-api-key": "7ec3dc5e-7268-4693-9e9a-494c5d521fcd",
                       "platform": "ios",
                       "version": "1"]
        if withAuth {
            headers["Authorization"] = "Bearer \(self.getToken())"
        }
        return headers
    }
    
    static func setToken(token: String) -> Void {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "authtoken")
        defaults.synchronize()
    }
    
    static func getToken() -> String {
        if let token = UserDefaults.standard.string(forKey: "authtoken") {
            return token
        }
        return ""
    }
    
    static func setUserId(userId: String) -> Void {
        let defaults = UserDefaults.standard
        defaults.set(userId, forKey: "member_id")
        Crashlytics.sharedInstance().setUserIdentifier(userId)
        defaults.synchronize()
    }
    
    static func getUserId() -> String {
        if let memberId = UserDefaults.standard.string(forKey: "member_id") {
            return memberId
        }
        return ""
    }
    
    static func resetStorage() {
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "authtoken")
        defaults.set("", forKey: "member_id")
        defaults.synchronize()
    }
    
    static func signOut() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UserHelper.resetStorage()
        appDelegate.logged = false
        appDelegate.loginHandler()
    }
    
    static func getBTClientToken() -> String {
        if let btToken = UserDefaults.standard.string(forKey: "brainTreeToken") {
            return btToken
        }
        return ""
    }
    
    static func setBTClientToken(token: String) -> Void {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "brainTreeToken")
        defaults.synchronize()
    }
    
    static func getDefaultApiErrors(errorId: String = "something_went_wrong", message: String = "Something went wrong. Please try again!") -> AFErrors {
        let error = AFValidationError(id: errorId, message: message)
        return AFErrors(errors: [error])
    }
}

