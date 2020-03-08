//
//  UserDecodable.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 2/28/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import Foundation


struct User: Decodable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var displayName: String
    var imageURL: URL
    var correctionPoint: Int
    var poolMonth: String
    var poolYear: String
    var wallet: Int
    var login: String
    var location: String?
    var projectsAll: [Projects]
    var cursusAll: [CursusInfo]

    struct Projects: Decodable {
        var finalMark: Int?
        var status: String
        var cursusId: [Int]
        var project: ProjectInfo
        
        enum CodingKeys : String, CodingKey {
            case finalMark = "final_mark"
            case status
            case cursusId = "cursus_ids"
            case project = "project"
        }
    }
    
        struct ProjectInfo: Decodable {
            var name: String
            var slug: String
        }
        
    struct CursusInfo: Decodable {
        var beginAt: String
        var level: Double
        var cursus: Cursus
        var skills: [SkillsInfo]
        
        enum CodingKeys : String, CodingKey {
            case beginAt = "begin_at"
            case level
            case skills = "skills"
            case cursus
        }
    }
        struct Cursus: Decodable{
            var name: String
            var slug: String
        }

        struct SkillsInfo: Decodable {
            var name: String
            var level: Double
        }
    
    enum CodingKeys : String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case displayName = "displayname"
        case imageURL = "image_url"
        case correctionPoint = "correction_point"
        case poolMonth = "pool_month"
        case poolYear = "pool_year"
        case wallet
        case location
        case login

        case projectsAll = "projects_users"
        case cursusAll = "cursus_users"
    }
}
