//
//  UserPageViewController.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 2/28/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import UIKit

class UserPageViewController: UIViewController {
    
    var userSent: User?
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var availableAt: UILabel!
    @IBOutlet weak var shortInfo: UIView!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var levelConstant: NSLayoutConstraint!
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var levelProgress: UILabel!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var tabBar: UISegmentedControl!
    @IBOutlet weak var topView: UIView!
    
    
    // MARK: - Functions
    @IBAction func backButtonPressed() {
        performSegue(withIdentifier: "backSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setingUpView()
    }

    // MARK: - View Settings
    func setingUpView() {
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
        
        guard let user = userSent else { return }
        
        let data = try? Data(contentsOf: user.imageURL)
        imageView.image = UIImage(data: data!)
        fullName.text = "\t\(user.displayName)"
        if let location = user.location {
            availableAt.text = "\tAvailable at \(location)"
        } else {
            availableAt.text = "\tUnavailable"
        }
        let levelComponents = String(user.cursusAll[0].level).components(separatedBy: ".")
        level.text = "level \(levelComponents[0]) - \(levelComponents[1])"
        let levelPercent = user.cursusAll[0].level.truncatingRemainder(dividingBy: 1)
        let levelWidth = level.frame.size.width
        levelConstant.constant = levelWidth * CGFloat(1 - levelPercent)
        
        availableAt.layer.masksToBounds = true
        fullName.layer.masksToBounds = true
        levelProgress.layer.masksToBounds = true
        level.layer.masksToBounds = true
        
        availableAt.layer.cornerRadius = availableAt.frame.size.height / 4
        fullName.layer.cornerRadius = fullName.frame.size.height / 4
        levelProgress.layer.cornerRadius = levelProgress.frame.size.height / 4
        levelView.layer.cornerRadius = levelView.frame.size.height / 4
        
        //Gradient
        
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [#colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 0.4993043664).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0).cgColor]
//        gradient.locations = [0.0 , 1.0]
//        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: topView.frame.size.width, height: topView.frame.size.height)
        topView.layer.insertSublayer(gradient, at: 0)
    }
}


