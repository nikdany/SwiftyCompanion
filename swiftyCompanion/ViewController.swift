//
//  ViewController.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 2/19/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBAction func intraLogin(_ sender: UIButton) {
        
        connectLogin(userName: userName.text)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        postRequestToken()
    }
    
    
    
    func connectLogin(userName: String?) {
        guard let userName = userName, userName != "", API.token != nil else { return }
        let session = URLSession.shared
        guard let url = URL(string: API.intraURL + API.getUser + userName) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer " + API.token!, forHTTPHeaderField: "Authorization")
            
            session.dataTask(with: request) { (data, response, error) in

                guard let data = data else { return }
                guard error == nil else { return }
                
                do {
                    let intraUser = try JSONDecoder().decode(User.self, from: data)
//                    print(intraUser)
                    for project in intraUser.projectsUsers {
//                        let name = project?.project, let mark = project?.finalMark, let status = project?.status
                        print("\(project?.project) \(project?.finalMark) \(project?.status)")
                    }
                    for user in intraUser.cursusUsers {
                        for skill in user!.skills {
                            guard let name = skill?.name, let level = skill?.level else {return}
                            print("\(name)  \(level)")
                        }
                    }
                } catch let error {
                    print("tut", error)
                }
            }.resume()
        }
        
    func postRequestToken() {
            
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
                print(intraToken)
                API.token = intraToken.access_token
            } catch let error {
                print("tut", error)
            }
        }.resume()
    }
}
