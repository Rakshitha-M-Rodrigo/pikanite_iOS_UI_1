

import Foundation

class ValidationHelper {
    static func confirmPasswords(password1: String = "", password2: String = "")  -> Bool {
        if password1 != "" && password2 != "" && password1.elementsEqual(password2) {
            return true
        }
        return false
    }
}
