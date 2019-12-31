//
//  BookShelfModel.swift
//  RaccoonDog
//
//  Created by carrot on 24/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BookShelfModel {
    var bookshelf_num : Int?
    var cate_id : Int?
    var favorite_num : Int = 0
//    var id : Int!
    var download_num : Int = 0
    var novel_status : Int?
    var top_value : Int?
    var rank_value : Int?
    var read_num : Int?
    var score : Double?
    
    
    var updated_at : String?
    var author : String?
    var cate_title : String?
    var created_at : String?
    var description : String?
    var face : String?
    var is_show : String?
    var rank_direction : String?
    var source_category : String?
    var book_uuid : String!
    var source_url : String?
    var title : String?
    var is_on_bookshelf : Bool?
    
    
    
    
    var first_letter : String?
    var source_domain : String?
    
    
    
//    "is_on_bookshelf": false,
//    "is_show": "on",
//    "author": "唐家三少",
//    "bookshelf_num": 0,
//    "cate_id": 1,
//    "cate_title": "玄幻",
//    "created_at": "2019-12-03 17:21:47",
//    "description": "唐门外门弟子唐三，因偷学内门绝学为唐门所不容，跳崖明志时却发现没有死，反而以另外一个身份来到了另一个世界，一个属于武魂的世界，名叫斗罗大陆。这里没有魔",
//    "download_num": 1,
//    "face": "https://bookcover.yuewen.com/qdbimg/349573/1115277/180",
//    "favorite_num": 0,
//    "first_letter": "d",
//    "id": 1,
//    "is_show": "on",
//    "novel_status": 0,
//    "rank_direction": "down",
//    "rank_value": 3,
//    "read_num": 452,
//    "score": 4.8,
//    "source_category": "",
//    "source_domain": "",
//    "source_url": "http://app.com",
//    "source_uuid": "e10abc2de10abc2de10abc2de10abc2d",
//    "title": "斗罗大陆",
//    "top_value": 3,
//    "updated_at": "2019-12-27 03:20:03"

    class func getModel(data:Any?) -> BookShelfModel?{
        guard let item = data as? Dictionary<String,Any> ,let book_uuid = item["book_uuid"] as? String else {
            return nil
        }

        
        let model = BookShelfModel.init(book_uuid: book_uuid)
//        model.book_uuid = book_uuid

        model.is_on_bookshelf = item["is_on_bookshelf"] as? Bool
        if let bookshelf_num = item["bookshelf_num"] as? Int {
            model.bookshelf_num = bookshelf_num
        }
        if let cate_id = item["cate_id"] as? Int {
            model.cate_id = cate_id
        }
        if let favorite_num = item["favorite_num"] as? Int {
            model.favorite_num = favorite_num
        }
        if let download_num = item["download_num"] as? Int {
            model.download_num = download_num
        }
        if let novel_status = item["novel_status"] as? Int {
            model.novel_status = novel_status
        }
        if let top_value = item["top_value"] as? Int {
            model.top_value = top_value
        }
        if let rank_value = item["rank_value"] as? Int {
            model.rank_value = rank_value
        }
        if let read_num = item["read_num"] as? Int {
            model.read_num = read_num
        }
        if let score = item["score"] as? Double {
            model.score = score
        }
        if let updated_at = item["updated_at"] as? String {
            model.updated_at = updated_at
        }
        if let author = item["author"] as? String {
            model.author = author
        }
        if let cate_title = item["cate_title"] as? String {
            model.cate_title = cate_title
        }
        if let created_at = item["created_at"] as? String {
            model.created_at = created_at
        }
        if let description = item["description"] as? String {
            model.description = description
        }
        if let face = item["face"] as? String {
            model.face = face
        }
        if let is_show = item["is_show"] as? String {
            model.is_show = is_show
        }
        if let rank_direction = item["rank_direction"] as? String {
            model.rank_direction = rank_direction
        }
        if let source_category = item["source_category"] as? String {
            model.source_category = source_category
        }

        if let source_url = item["source_url"] as? String {
            model.source_url = source_url
        }
        if let title = item["title"] as? String {
            model.title = title
        }
        if let first_letter = item["first_letter"] as? String {
            model.first_letter = first_letter
        }
        if let source_domain = item["source_domain"] as? String {
            model.source_domain = source_domain
        }
        return model
        
        
    }
    init(book_uuid:String) {
        self.book_uuid = book_uuid
    }
    
    
//    "author": "唐家三少",
//    "bookshelf_num": 0,
//    "cate_id": 1,
//    "cate_title": "玄幻",
//    "created_at": "2019-12-03 17:21:47",
//    "description": "唐门外门弟子唐三，因偷学内门绝学为唐门所不容，跳崖明志时却发现没有死，反而以另外一个身份来到了另一个世界，一个属于武魂的世界，名叫斗罗大陆。这里没有魔",
//    "download_num": 1,
//    "face": "https://bookcover.yuewen.com/qdbimg/349573/1115277/180",
//    "favorite_num": 0,
//    "id": 1,
//    "is_show": "on",
//    "novel_status": 0,
//    "rank_direction": "down",
//    "rank_value": 3,
//    "read_num": 422,
//    "score": 4.8,
//    "source_category": "",
//    "source_id": "",
//    "source_url": "http://app.com",
//    "title": "斗罗大陆",
//    "top_value": 3,
//    "updated_at": "2019-12-24 01:59:22"
}
