//
//  APIManager.swift
//  Hacked Airline
//
//  Created by Dr. Drake 007 on 30/09/2019.
//  Copyright © 2019 Dr. Drake 007. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {

    class func headers() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Authorization": "Bearer e3m9nwnzymkkv5r59qdvqbjz",
            "Accept": "application/json",
            "X-Originating-IP": "64.190.114.174"
        ]

        if let authToken = UserDefaults.standard.string(forKey: "auth_token") {
            headers["Authorization"] = "Token" + " " + authToken
        }

        return headers
    }
}
