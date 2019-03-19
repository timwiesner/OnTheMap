//
//  Udacity.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/19/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import Foundation

struct Udacity: Codable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
