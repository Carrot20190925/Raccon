//
//  BookStoreModel.swift
//  RaccoonDog
//
//  Created by carrot on 30/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation

//MARK:-  书城标题模型
class BookStoreModel {
    var module_title : String!
    var module_status : Int?
    var remark : String?
    var id : Int!
    
    
    init(id:Int,title:String) {
        self.id = id;
        self.module_title = title
         
    }
    
    class func getModel(data:Any) -> BookStoreModel? {
        guard let item = data as? Dictionary<String,Any> ,let title = item["module_title"] as? String,let id = item["id"] as? Int else{
            return nil
        }
        let model = BookStoreModel.init(id: id, title: title)
        if let status = item["module_status"] as? Int{
            model.module_status = status
        }
        if let remark = item["remark"] as? String{
            model.remark = remark
        }
        return model
        
    }
    
    
}


//MARK:-  书城列表模型

class BookListModel {
    
    var id : Int!
    
    var mt_status : Int?
    
    var mt_title : String?
    
    var page_type : String?
    var remark : String?
    
    
    
    var novelList : NovelListModel?
//    "page_type": "autochange",
//    "remark": ""
    init(id:Int) {
        self.id = id;
    }
    
    class func getModel(data : Any?) ->  BookListModel?{
        guard let item = data as? Dictionary<String,Any>,let id = item["id"] as? Int else {
            return nil
        }
        let model = BookListModel.init(id: id)
        if let mt_status = item["mt_status"] as? Int {
            model.mt_status = mt_status
        }
        if let mt_title = item["mt_title"] as? String {
            model.mt_title = mt_title
        }
        if let page_type = item["page_type"] as? String {
            model.page_type = page_type
        }
        if let remark = item["remark"] as? String {
            model.remark = remark
        }
        
        
        model.novelList = NovelListModel.getModel(data: item["novelList"])

        return model;
    }
    
    
}

class NovelListModel {
    
    //        "first_page_url": 1,
    //        "last_page": 2,
    //        "last_page_url": 2,
    //        "next_page_url": 2,
    //        "per_page": 6,
    //        "prev_page_url": null,
    //        "total": 10
    var current_page = 0

    var data : [BookShelfModel]?
    init() {
        
    }
    
    class func getModel(data : Any?) -> NovelListModel? {
        guard let item = data as? Dictionary<String,Any> else {
            return nil
        }
        let model = NovelListModel.init()
        if let current_page = item["current_page"] as? Int{
            model.current_page = current_page
        }
    
        

        if let datas = item["data"] as? Array<Dictionary<String,Any>>{
            var models : [BookShelfModel] = []
            for item in datas {
                if let model = BookShelfModel.getModel(data: item){
                    models.append(model)
                }
            }
            model.data = models
        }
        return model
        
    }
    
}
