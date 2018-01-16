//
//  MatherModel.swift
//  Mather-iOS
//
//  Created by Kevin Springer on 1/15/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import Alamofire

protocol MatherModelDelegate {
    func dataReady()
}

class MatherModel: NSObject {
//    let API_URL = "http://127.0.0.1:3000/api"
    let API_URL = "https://mather-server.herokuapp.com/api"
    var total: Int? = nil
    var delegate: MatherModelDelegate?
    
    func addem(num1: Int, num2: Int) {
        let parameters = [ "numbers": [num1, num2] ]
        Alamofire.request("\(API_URL)/addem", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let jsonData = response.data {
                    struct Object: Codable {
                        let total: Int
                    }
                    let decoder = JSONDecoder()
                    if let result = try? decoder.decode(Object.self, from: jsonData) {
                        self.total = result.total
                        if self.delegate != nil {
                            self.delegate!.dataReady()
                        }
                    }
                }
            }
    }
}
