//
//  LocationResult.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/19/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import Foundation

struct LocationResult: Codable {
    let results: [StudentLocation]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
