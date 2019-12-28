//
//  NovelChapterModel.swift
//  RaccoonDog
//
//  Created by carrot on 25/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation
class NovelChapterModel {
    var chapter_no : Int = 0
    var chapter_content : String?
    var chapter_title : String?
    var id : Int = 0
    var novel_id : String!

    var volume : Int = 0
    var isRead : Bool = false
    var isCurrentRead = false
    
    
    private init(novel_id : String,chapter_no : Int){
        self.novel_id = novel_id
        self.chapter_no = chapter_no
    }
    //MARK:-  根据模型获取数据
    static func getModel(data : Any?) -> NovelChapterModel? {
        guard let item = data as? Dictionary<String,Any>,let chapter_no = item["chapter_no"] as? Int,let novel_id = item["book_uuid"] as? String else {
            return nil
        }
        let model = NovelChapterModel.init(novel_id: novel_id, chapter_no: chapter_no)
        if let chapter_title = item["chapter_title"] as? String {
            model.chapter_title = chapter_title
        }
        if let chapter_content = item["chapter_content"] as? String {
            model.chapter_content = chapter_content
        }
        if let id = item["id"] as? Int {
            model.id = id
        }
        if let volume = item["volume"] as? Int {
            model.volume = volume
        }
        
        if let isRead = item["isRead"] as? Bool {
            model.isRead = isRead
        }
        
        if let isCurrentRead = item["isCurrentRead"] as? Bool {
            model.isCurrentRead = isCurrentRead
        }
        return model
        
        
    }
    
    func save()  {
        var data : Dictionary <String,Any>  = [:]
        data["chapter_no"] = chapter_no
        data["book_uuid"] = novel_id
        if let chapter_title = self.chapter_title{
            data["chapter_title"] = chapter_title
        }
        if let chapter_content = self.chapter_content{
            data["chapter_content"] = chapter_content
        }
        data["id"] = id
        data["volume"] = volume
        data["isRead"] = isRead
        data["isCurrentRead"] = isCurrentRead
        RD_DBManager.share.updateNovelList(data: data)
    }
}
//"chapter_content": "http://10.10.35.201:8081/api/v1/TestNovelContent",
//"chapter_no": 1,
//"chapter_title": "斗罗大陆，异界唐三",
//"created_at": "2019-12-06 02:06:49",
//"id": 1,
//"novel_id": 1,
//"volume": 1
