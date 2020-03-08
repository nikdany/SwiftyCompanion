//
//  UserPageViewController.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 2/28/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import UIKit

struct RowData {
    let fieldName: String
    let value: String
    
}

class UserPageViewController: UIViewController {
    
    var userSent: User?
    var rowsToDisplay : [RowData] = []
    lazy var cellName = "OverviewCell"
    lazy var overviewData : [RowData] = []
    lazy var projectData : [RowData] = []
    lazy var skillData : [RowData] = []
//    lazy var rowsToDisplay = arrayOverview
    
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
//    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var tabBar: UISegmentedControl!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableViewInfo: UITableView!
    
    
    // MARK: - Functions
    @IBAction func backButtonPressed() {
        performSegue(withIdentifier: "backSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         guard let user = userSent else { return }
        setingUpView(user: user)
        settingUpTableData(user: user)
    }

    // MARK: - View Settings
    func setingUpView(user: User) {
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
        
       
        
        
//        tableViewInfo.register(UINib(nibName: "OverviewCell", bundle: nil), forCellReuseIdentifier: "infoCell")
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
    
    func settingUpTableData(user: User){
        overviewData = [RowData(fieldName: "Full name", value: user.displayName),
        RowData(fieldName: "login", value: user.login),
        RowData(fieldName: "email", value: user.email),
        RowData(fieldName: "Pool month", value: user.poolMonth),
        RowData(fieldName: "Pool Year", value: user.poolYear),
        RowData(fieldName: "Evaluation points", value: "\(user.correctionPoint)"),
        RowData(fieldName: "Wallet", value: "\(user.wallet) ₳")]
        
        rowsToDisplay = overviewData
        
        for project in user.projectsAll where project.cursusId.contains(1) && !project.project.slug.hasPrefix("piscine") && !project.project.slug.hasPrefix("rushes") {
            projectData.append(RowData(fieldName: project.project.name, value: "\(project.finalMark ?? 0)"))
        }
            
        for skill in user.cursusAll[0].skills{
            skillData.append(RowData(fieldName: skill.name, value: String(format: "%.2f", skill.level)))
        }
    }
    
    
    @IBAction func chooseSegment(_ sender: UISegmentedControl) {

        switch tabBar.selectedSegmentIndex {
        case 0:
            cellName = "OverviewCell"
            rowsToDisplay = overviewData
        case 1:
            cellName = "OverviewCell"
            rowsToDisplay = projectData
        case 2:
            cellName = "OverviewCell"
            rowsToDisplay = skillData
        default:
            print("Ooooops")
        }
        tableViewInfo.reloadData()
        
    }

}

extension UserPageViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(cellName, owner: self, options: nil)?.first as! OverviewCell
        cell.fieldName.text = rowsToDisplay[indexPath.row].fieldName
        cell.fieldValue.text = rowsToDisplay[indexPath.row].value
        return cell
    }
}


