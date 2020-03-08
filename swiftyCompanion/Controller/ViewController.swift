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

    var userSent : User?
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var activiryIndicator: UIActivityIndicatorView!
    @IBOutlet weak var getUserButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue){
        guard segue.identifier == "backSegue" else { return }
        self.userName.text = ""
    }
    
    @IBAction func intraLogin() {
        guard let userName = userName.text, !userName.isEmpty else { return }
        toggleActivityIndicator(on: true)
        NetworkService.shared.getData(userName: userName) { (responce) in
            
            self.toggleActivityIndicator(on: false)
            self.userSent = responce
            self.performSegue(withIdentifier: "ShowSecond", sender: nil)
            
        }
        
    }
    
    func toggleActivityIndicator(on: Bool) {
      if on {
        activiryIndicator.startAnimating()
      } else {
        activiryIndicator.stopAnimating()
      }
    }
    
    override func viewDidLoad() {
        getUserButton.layer.cornerRadius = getUserButton.frame.height / 2
        super.viewDidLoad()

        userName.text = "mdanylch"
        NetworkService.shared.postRequestToken()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowSecond" else { return }
        guard let destination = segue.destination as? UserPageViewController else { return }
        
        destination.userSent = userSent
    }
        
}

