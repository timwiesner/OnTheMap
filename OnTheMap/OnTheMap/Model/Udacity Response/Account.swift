//
//  Account.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/19/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import Foundation

struct Account: Codable {
    let registered: Bool
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case registered
        case key
    }
}
