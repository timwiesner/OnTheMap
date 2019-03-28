//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Tim Wiesner on 3/19/19.
//  Copyright © 2019 Tim Wiesner. All rights reserved.
//

import Foundation

class UdacityClient {
    static let udacityBase = "https://onthemap-api.udacity.com/v1/session"
    
//    struct Auth {
//        static var sessionId = ""
//    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, SessionResponse?, Error?) -> Void) {
        let body = LoginRequest(udacity: Udacity(username: username, password: password))
        
        taskForPOSTRequest(url: Endpoints.createSessionId.url, responseType: SessionResponse.self, body: body) { (response, error) in
            if response != nil {
                completion(true, response!, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.addValue(Endpoints.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Endpoints.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
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
        request.addValue(Endpoints.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
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
            let newData = data.subdata(in: 5..<data.count)
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
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
