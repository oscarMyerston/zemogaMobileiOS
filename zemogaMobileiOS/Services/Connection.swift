//
//  Connection.swift
//  meliMobileiOS
//
//  Created by Oscar David Myerston Vega on 3/09/22.
//

import Foundation
import Alamofire

typealias ConnectionResponse = ( (_ response: Result<Data, TypeError>) -> Void )

class Connection {

    static func sendRequest (endPoint: String, completion: @escaping ConnectionResponse) {
        let url = HomeModel.Constants.urlSecure + endPoint
        
        AF.request(url, method: .get).response { (response) in
            if let error = response.error {
                print("Can't get response from server: ", error.localizedDescription)
                completion(.failure(.requestError))
                return
            }
            
            if let response = response.response {
                if response.statusCode != 200 {
                    completion(.failure(.serverError))
                }
            }
            
            if let data = response.data {
                completion(.success(data))
            }
        }
    }
}
