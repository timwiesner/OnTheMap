//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/18/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import Foundation

class ParseClient {
    
    static var applicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    enum Endpoints {
        static let parseBase = "https://parse.udacity.com/parse/classes"
//        static let udacityBase = "https://onthemap-api.udacity.com/v1/session"
        
        case getStudentLocation
        case postStudentLocation
        
        var stringValue: String {
            switch self {
            case .getStudentLocation: return Endpoints.parseBase + "/studentlocation?limit=100&order=-updatedAt"
            case .postStudentLocation: return Endpoints.parseBase + "/studentlocation"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }

    //    MARK: GetStudentLocation
    class func getStudentLocation(completion: @escaping ([StudentLocation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getStudentLocation.url, response: LocationResult.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    //    MARK: PostStudentLocation
    class func postStudentLocation(body: StudentLocation, completion: @escaping (Bool, Error?) -> Void) {
        taskForPOSTRequest(url: Endpoints.postStudentLocation.url, responseType: StudentResponse.self, body: body) { (response, error) in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
//    class func updateStudentLocation(objectId: String, completion: @escaping ())
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.addValue(ParseClient.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseClient.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(ParseClient.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseClient.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }

}
