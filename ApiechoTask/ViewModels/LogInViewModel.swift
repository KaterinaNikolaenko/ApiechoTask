//
//  LogInViewModel.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

class LogInViewModel: NSObject {
    
    var dataRequest = PostLoginRequest()
    
    // Log in to Server
    func postLogin(completion: @escaping (Bool) -> ()) {
        
        HttpClient.sharedInstance.postLogIn(data: dataRequest, successCallback: { (dataResponse) -> Void in
            UserDefaults.standard.set(dataResponse.accessToken, forKey: "accessToken")
            completion(true)
        }) { (error) -> Void in
            completion(false)
        }
    }
    
    // Sign up
    func postSignUp(completion: @escaping (Bool) -> ()) {
        
        HttpClient.sharedInstance.postSignUp(data: dataRequest, successCallback: { (dataResponse) -> Void in
            UserDefaults.standard.set(dataResponse.accessToken, forKey: "accessToken")
            completion(true)
        }) { (error) -> Void in
            completion(false)
        }
    }
}
