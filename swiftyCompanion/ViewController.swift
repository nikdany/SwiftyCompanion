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
    @IBAction func intraLogin() {
        guard let userName = userName.text, userName != "", API.token != nil else { return }
                NetworkService.shared.getData(userName: userName) { (responce) in
                    print(responce)
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        NetworkService.shared.postRequestToken { (token) in
            API.token = token
        }
    }
        
}
