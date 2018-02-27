//
//  GetTextResponse.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import ObjectMapper

class StringApiResponse: BaseApiResponse  {
    var dataText = ""
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        dataText <- map["data"]
    }
}


