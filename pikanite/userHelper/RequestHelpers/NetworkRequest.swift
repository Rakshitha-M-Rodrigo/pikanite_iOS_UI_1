

import Foundation
import Alamofire

protocol NetworkRequest {
    
    func request(
        _ url: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        completion: @escaping (Result<Json>) -> Void)
        -> Void
}
