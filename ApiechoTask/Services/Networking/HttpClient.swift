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
    func postLogIn(data:PostLoginRequest, successCallback: @escaping (User) -> (), errorCallback: @escaping ([ApiError]) -> ()) {
        let url = Constants.URLs.baseURL + "login/"
        let parameters: Parameters = [
            "email": data.email,
            "password": data.password
        ]
        Alamofire.request(url, method: .post, parameters: parameters).responseObject{ (response: DataResponse<ObjectApiResponse<User>>) in
            let fatalError = ApiError()
            fatalError.name = "Error"
            fatalError.message = "Fatal Error"
            guard response.response != nil || response.result.value != nil else {
                errorCallback([fatalError])
                return
            }
            if(!response.result.value!.success){
                errorCallback(response.result.value!.errors)
            } else {
                successCallback((response.result.value?.data)!)
            }
        }
    }
    
    //Sign up
    func postSignUp(data:PostLoginRequest, successCallback: @escaping (User) -> (), errorCallback: @escaping ([ApiError]) -> ()) {
        let url = Constants.URLs.baseURL + "signup/"
        let parameters: Parameters = [
            "name": data.name,
            "email": data.email,
            "password": data.password
        ]
        Alamofire.request(url, method: .post, parameters: parameters).responseObject{ (response: DataResponse<ObjectApiResponse<User>>) in
            let fatalError = ApiError()
            fatalError.name = "Error"
            fatalError.message = "Fatal Error"
            guard response.response != nil || response.result.value != nil else {
                errorCallback([fatalError])
                return
            }
            if(!response.result.value!.success){
                errorCallback(response.result.value!.errors)
            } else {
                successCallback((response.result.value?.data)!)
            }
        }
    }
    
    //Get text
    func getText(successCallback: @escaping (StringApiResponse) -> (), errorCallback: @escaping ([ApiError]) -> ()) {
        let url = Constants.URLs.baseURL + "get/text/"
        let locale = deviceLocale()
        let parameters: Parameters = [
            "locale": locale
        ]
        Alamofire.request(url, method: .get, parameters: parameters, headers: setHeaders()).responseObject{ (response: DataResponse<StringApiResponse>) in
            let fatalError = ApiError()
            fatalError.name = "Error"
            fatalError.message = "Fatal Error"
            guard response.response != nil || response.result.value != nil  else {
                errorCallback([fatalError])
                return
            }
            if(!response.result.value!.success){
                errorCallback(response.result.value!.errors)
            } else {
                successCallback((response.result.value)!)
            }
        }
    }
    
    func deviceLocale() -> String {
        let languageComponents: [String : String] = NSLocale.components(fromLocaleIdentifier: NSLocale.preferredLanguages[0])
        var currentlanguage = "en"
        var currentcountry = "US"
        
        if let languageCode: String = languageComponents[NSLocale.Key.languageCode.rawValue] {
            currentlanguage = languageCode
        }
        if let countryCode: String = languageComponents[NSLocale.Key.countryCode.rawValue] {
            currentcountry = countryCode
        }
        return currentlanguage + "_" + currentcountry
    }
}
