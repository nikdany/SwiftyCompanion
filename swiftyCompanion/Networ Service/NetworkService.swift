//
//  NetworkService.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 2/28/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import Foundation


struct IntraAccess: Decodable {
    var token: String

    enum CodingKeys : String, CodingKey {
        case token = "access_token"
    }
}

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    private let intraURL = "https://api.intra.42.fr"
    private let getToken = "/oauth/token"
    private let getUser = "/v2/users/"
    private let getCoalition = "/v2/coalitions_users/:id"
    private let UID = "d467eabb1e8c1abee90d8b332f4bff3756ad888fa4015e56aa0b21eb2fca138e"
    private let secretKey = "10244b3f3da2369fed64efecb59349808db19bac6eb796c529c2719b4e2fdcc1"
    private let callback = "com.swiftyCompanion://mdanylch"
    private var token = ""
    
    
    func getData(userName: String, completion: @escaping (User) -> ()) {
        
        guard !token.isEmpty else { return }
        guard let url = URL(string: intraURL + getUser + userName) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    
        decode(request: request, model: User.self) { (user) in
            completion(user)
        }
        
    }
    
    
    func postRequestToken() {
        
        guard let url = URL(string: intraURL + getToken) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "grant_type=client_credentials&client_id=\(UID)&client_secret=\(secretKey)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        decode(request: request, model: IntraAccess.self) { (getToken) in
            self.token = getToken.token
        }
    }
    
    func decode<T>(request: URLRequest, model: T.Type,  completion: @escaping(T) -> ()) where T : Decodable{
        
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    guard let data = data else { return }
                    guard error == nil else { return }
                    
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(result)
                    } catch let error {
                        print("JSON Decoding Error", error)
                    }
                    
                }
            }.resume()
    }
    
}
