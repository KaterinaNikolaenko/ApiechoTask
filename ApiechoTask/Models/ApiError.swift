//
//  ApiError.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import ObjectMapper

class ApiError: Mappable  {
    var message:String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
    }
}

