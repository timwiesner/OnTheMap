//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/18/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String
    let latitude: Double?
    let longitude: Double?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case objectId
        case uniqueKey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude
        case longitude
        case createdAt
        case updatedAt
    }
    
//    var validURL: String {
//        if mediaURL != nil {
//            return "\(mediaURL!)"
//        }
//        return ""
//    }
    
    var studentName: String {
        var name = ""
        if firstName != nil {
            name = "\(firstName!)"
            if lastName != nil {
                name = "\(firstName!) \(lastName!)"
            } else {
                name = "\(lastName!)"
            }
        } else {
            name = "Invalid name"
        }
        return name
    }
}
