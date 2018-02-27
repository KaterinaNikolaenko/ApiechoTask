//
//  BaseApiResponse.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseApiResponse: Mappable {
    var success = false
    var errors = [ApiError]()
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        errors <- map["errors"]
    }
}
