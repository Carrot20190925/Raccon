//
//  BaseModel.swift
//  RaccoonDog
//
//  Created by carrot on 23/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    var code : Int = 0
    var message : String?
    var data : Any?
    static func getModel(data:Any?) -> BaseModel?{
        guard let item = data as? Dictionary<String,Any>  else {
            return nil
        }
        let model = BaseModel.init()
        if let code = item["code"] as? Int {
            model.code = code
        }
        if let msg = item["msg"] as? String {
            model.message = msg
        }
        model.data = item["data"]
        return model
        
        
    }

}
