//
//  Endpoints.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/19/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import Foundation

enum Endpoints {
    
    static var applicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    static let parseBase = "https://parse.udacity.com/parse/classes"
    static let udacityBase = "https://onthemap-api.udacity.com/v1"
    
    case getStudentLocation
    case postStudentLocation
    case getUserData
    case createSessionId
    
    var stringValue: String {
        switch self {
        case .getStudentLocation: return Endpoints.parseBase + "/studentlocation?limit=100&order=-updatedAt"
        case .postStudentLocation: return Endpoints.parseBase + "/studentlocation"
        case .getUserData: return Endpoints.udacityBase + "/users/"
        case .createSessionId: return Endpoints.udacityBase + "/session"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
