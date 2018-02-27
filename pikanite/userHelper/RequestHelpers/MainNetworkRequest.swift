

import Foundation
import Alamofire

class MainNetworkRequest: NetworkRequest {
    func request(_ url: String, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (Result<Json>) -> Void) {
        
        Alamofire.request(url,
                          method: method,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers).responseJSON(completionHandler: { (response) in
                            if let value = response.result.value, let result = Json(json: value) {
                                completion(.success(result))
                            } else {
                                completion(.error)
                            }
                          })
    }
}
