//
//  APIManager.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 2/20/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import Foundation

typealias  JSONTask = URLSessionDataTask
typealias  JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration {  get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask
    func fetch<T>(request: URLRequest, parse: ([String: AnyObject]) -> T?, competionHandler: (APIResult<T>) -> Void)
    
//    init(sessionConfiguration: URLSessionConfiguration)
}

extension APIManager {
//    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
//        
//        let dataTask = session.dataTask(with: request) { (data, response, error) in
//            
//            guard let HTTPResponse = response as? HTTPURLResponse else {
//                
//                let userInfo = [
//                    NSLocalizedDescriptionKey: NSLocalizedString("MissingHTTPResponse", comment: "")
//                ]
//                let error = NSError(domain: SWINetworkingErrorDomain, code: 100, userInfo: userInfo)
//                
//                completionHandler(nil, nil, error)
//                return
//            }
//            
//            if data == nil {
//                if let error = error {
//                    completionHandler(nil, HTTPResponse, error)
//                }
//            } else {
//                switch HTTPResponse.statusCode {
//                case 200:
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
//                        completionHandler(json, HTTPResponse, nil)
//                    } catch let error as NSError {
//                        completionHandler(nil, HTTPResponse, error)
//                    }
//                default:
//                    print("Got response status \(HTTPResponse.statusCode)")
//                }
//            }
//        }
//        return dataTask
//    }
//    
//    func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, competionHandler: @escaping  (APIResult<T>) -> Void){
////    func fetch<T>(request: URLRequest, parse: ([String: AnyObject]) -> T?, competionHandler: (APIResult<T>) -> Void) {
//        
//        let dataTask = JSONTaskWith(request: request) { (json, response, error) in
//            guard let json = json else {
//                if let error = error {
//                    competionHandler(.Failure(error))
//                }
//                return
//            }
//            
//            if let value = parse(json) {
//                competionHandler(.Success(value))
//            } else {
//                let error = NSError(domain: SWINetworkingErrorDomain, code: 200, userInfo: nil)
//                competionHandler(.Failure(error))
//            }
//        }
//        dataTask.resume()
//    }
}
