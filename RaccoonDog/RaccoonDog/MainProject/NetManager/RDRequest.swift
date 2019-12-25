//
//  RDRequest.swift
//  RaccoonDog
//
//  Created by carrot on 22/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation
class RDRequest {
    //默认是GET 请求
    var method = "GET"
    var url : String = ""
    var paramters : Dictionary <String,Any>?
    var authorHeader : Dictionary <String,String>?
    //请求
    
    
    
    init(method : String,url:String,paramters:Dictionary<String,Any>?,authorHeader:Dictionary<String,String>?){
        self.method = method
        self.url = url
        self.paramters = paramters
        if let headers = authorHeader{
            self.authorHeader = headers
        }else{
            if let account = RDAccountManager.share.localAccount(),account.token != nil {
                self.authorHeader = ["Authorization":account.token]
            }
        }
        
    }
    
}
