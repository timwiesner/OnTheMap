//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/19/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: Udacity
    
    enum CodingKeys: String, CodingKey {
        case udacity
    }
}
