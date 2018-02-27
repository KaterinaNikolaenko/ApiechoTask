//
//  Connectivity.swift
//  ApiechoTask
//
//  Created by Katerina on 27.02.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
