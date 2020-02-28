//
//  ModelDecodable.swift
//  swiftyCompanion
//
//  Created by Mykyta DANYLCHENKO on 2/27/20.
//  Copyright © 2020 Mykyta DANYLCHENKO. All rights reserved.
//

import Foundation

struct UserIntra {
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
    
    var beginAt: String
    var level: Float
    
    var skills: [Skills] = []
    
    var projects42: [Projects] = []

    struct Projects: Decodable{
        var finalMark: Int?
        var status: String
        var cursusId: [String]
//        var name: String
//        var slug: String
    }
    
    struct Skills: Decodable {
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
        case projectsAll = "projects_users"
        case cursusAll = "cursus_users"
        
        enum ProjectKeys : String, CodingKey {
            case finalMark = "final_mark"
            case status
            case cursusId = "cursus_ids"

//            enum ProjectsInfoKeys: String, CodingKey {
//                case name
//                case slug
//            }
        }
        
        enum CursusKeys : String, CodingKey {
                case beginAt = "begin_at"
                case level
                case cursus
                case skills
            
            enum SkillsInfoKeys: String, CodingKey {
                case name
                case slug
            }
        }

        
    }

    
    
    
    
}

extension UserIntra: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        email = try values.decode(String.self, forKey: .email)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        displayName = try values.decode(String.self, forKey: .displayName)
        imageURL = try values.decode(URL.self, forKey: .imageURL)
        correctionPoint = try values.decode(Int.self, forKey: .correctionPoint)
        poolMonth = try values.decode(String.self, forKey: .poolMonth)
        poolYear = try values.decode(String.self, forKey: .poolYear)
        wallet = try values.decode(Int.self, forKey: .wallet)
        login = try values.decode(String.self, forKey: .login)

        var cursusContainer = try values.nestedUnkeyedContainer(forKey: .cursusAll)
        let cursusEntry = try cursusContainer.nestedContainer(keyedBy: CodingKeys.CursusKeys.self)

        level = try cursusEntry.decode(Float.self, forKey: .level)
        beginAt = try cursusEntry.decode(String.self, forKey: .beginAt)

        var skillsContainer = try cursusEntry.nestedUnkeyedContainer(forKey: .skills)

        while !skillsContainer.isAtEnd{
            let skill = try skillsContainer.decode(Skills.self)
            skills.append(skill)
        }

        var projectsContainer = try values.nestedUnkeyedContainer(forKey: .projectsAll)
        while !projectsContainer.isAtEnd {
//            let projectsEntry = try projectsContainer.nestedContainer(keyedBy: CodingKeys.ProjectKeys.ProjectsInfoKeys.self)
            var project = try projectsContainer.decode(Projects.self)
//            project.name = try projectsEntry.decode(String.self, forKey: .name)
//            project.slug = try projectsEntry.decode(String.self, forKey: .slug)
            projects42.append(project)
        }


    }
}
