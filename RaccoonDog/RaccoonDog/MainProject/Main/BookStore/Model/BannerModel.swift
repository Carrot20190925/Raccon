//
//  BannerModel.swift
//  RaccoonDog
//
//  Created by carrot on 30/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation

class BannerModel  {
    
    var id : Int!
    var poster_img : String?
    var poster_title : String?
    var poster_url : String?
    
    private init(id : Int) {
        self.id = id
    }
    
    class func getModel(data : Any?) ->BannerModel?{
        guard let item = data as? Dictionary<String,Any> ,let id = item["id"] as? Int else {
            return nil
        }
        let model = BannerModel.init(id: id)
        
        model.poster_img = item["poster_img"] as? String
        model.poster_title = item["poster_title"] as? String
        model.poster_url = item["poster_url"] as? String
        return model;
    }
    
//    "created_at": "2019-11-30 17:57:07",
//    "id": 1,
//    "poster_dst": "bookinfo",
//    "poster_dst_value": "",
//    "poster_img": "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2380947688,3136358050&fm=26&gp=0.jpg",
//    "poster_status": 1,
//    "poster_title": "测试title",
//    "poster_type": 1,
//    "poster_url": "http://url.cn"
    
}
