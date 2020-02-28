//
//  NetworkService.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 2/28/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import Foundation

class NetworkService {
    private init() {}
    
    static let shared = NetworkService()
    
    func getData(userName: String, completion: @escaping (User) -> ()) {
        guard let url = URL(string: API.intraURL + API.getUser + userName) else { return }
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    request.setValue("Bearer " + API.token!, forHTTPHeaderField: "Authorization")
                
                    session.dataTask(with: request) { (data, response, error) in

                        guard let data = data else { return }
                        guard error == nil else { return }
                        
                        do {
                            let intraUser = try JSONDecoder().decode(User.self, from: data)
                            completion(intraUser)
                        } catch let error {
                            print("JSON Decoding Error GET", error)
                        }
                    }.resume()
        
    }
    
    func postRequestToken(completion: @escaping (String?) -> ()) {
            
        let session = URLSession.shared
        guard let url = URL(string: API.intraURL + API.getToken) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=client_credentials&client_id=\(API.UID)&client_secret=\(API.secretKey)".data(using: String.Encoding.utf8)
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let intraToken = try JSONDecoder().decode(IntraToken.self, from: data)
                completion(intraToken.access_token)
            } catch let error {
                print("JSON Decoding Error POST", error)
            }
        }.resume()
    }
}
