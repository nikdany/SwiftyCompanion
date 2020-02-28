//
//  Model.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 2/20/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import Foundation

struct IntraToken: Decodable {
    var access_token: String?
}

struct Intra {
    let intraURL = "https://api.intra.42.fr"
    let getToken = "/oauth/token"
    let getUser = "/v2/users/"
    let getCoalition = "/v2/coalitions_users/:id"
    let UID = "d467eabb1e8c1abee90d8b332f4bff3756ad888fa4015e56aa0b21eb2fca138e"
    let secretKey = "10244b3f3da2369fed64efecb59349808db19bac6eb796c529c2719b4e2fdcc1"
    let callback = "com.swiftyCompanion://mdanylch"
    var token: String?
}

var API = Intra()

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
//    var projects42: [Projects]
//    var skills42: [SkillsInfo]
    var projectsAll: [Projects]
    var cursusAll: [CursusInfo]

    struct Projects: Decodable {
        var finalMark: Int?
        var status: String
        var cursusId: [Int]
        var project: ProjectInfo
//        var name: String
//        var slug: String
        
        enum CodingKeys : String, CodingKey {
            case finalMark = "final_mark"
            case status
            case cursusId = "cursus_ids"
            case project = "project"
//            case name
//            case slug
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
        case login

//        case projects42
//        case skills42
        case projectsAll = "projects_users"
        case cursusAll = "cursus_users"
    }
}
