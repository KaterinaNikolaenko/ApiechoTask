//
//  PostLoginResponse.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import ObjectMapper

class PostLoginResponse: Mappable  {
    var accessToken:String = ""

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
    }
}
