//
//  HttpClient.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class HttpClient {
    
    static let sharedInstance = HttpClient()
    
    // Set headers with access_token
    func setHeaders() -> [String:String]? {
        if UserDefaults.standard.string(forKey: "accessToken") != nil {
            let headers = [
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken")!)"
            ]
            return headers
        } else {
            return nil
        }
    }
    
    //Log in
    func postLogIn(data:PostLoginRequest, successCallback: @escaping (PostLoginResponse) -> (), errorCallback: @escaping (String) -> ()) {
        let url = Constants.URLs.baseURL + "login/"
        let parameters: Parameters = [
            "email": data.email,
            "password": data.password
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: setHeaders()).responseObject(keyPath: "data", completionHandler: { (response: DataResponse<PostLoginResponse>) in
            
            guard response.response != nil else {
                errorCallback("Error!")
                return
            }
            if(!self.isSuccessStatus(status: (response.response?.statusCode)!)) {
                errorCallback("Error!")
            } else {
                successCallback(response.result.value!)
            }
        })
    }
    
    //Sign up
    func postSignUp(data:PostLoginRequest, successCallback: @escaping (PostLoginResponse) -> (), errorCallback: @escaping (String) -> ()) {
        let url = Constants.URLs.baseURL + "signup/"
        let parameters: Parameters = [
            "name": data.name,
            "email": data.email,
            "password": data.password
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: setHeaders()).responseObject(keyPath: "data", completionHandler: { (response: DataResponse<PostLoginResponse>) in
            
            guard response.response != nil else {
                errorCallback("Error!")
                return
            }
            if(!self.isSuccessStatus(status: (response.response?.statusCode)!)) {
                errorCallback("Error!")
            } else {
                successCallback(response.result.value!)
            }
        })
    }
    
    func isSuccessStatus(status:Int) -> Bool {
        return (status >= 200 && status < 300)
    }
}
