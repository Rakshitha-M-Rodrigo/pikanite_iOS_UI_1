

import Foundation
import SwiftyJSON

typealias JsonObject = JSON

enum Result<T> {
    case success(T)
    case error
}

enum Json {
    case object(_: JsonObject)
    case array(_: [JsonObject])
    
    init?(json: Any) {
        if let object = json as? JsonObject {
            self = .object(object)
            return
        }
        
        if let array = json as? [JsonObject] {
            self = .array(array)
            return
        }
        
        return nil
    }
}
