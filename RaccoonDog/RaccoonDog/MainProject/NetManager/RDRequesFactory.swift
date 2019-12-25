//
//  RDRequesFactory.swift
//  RaccoonDog
//
//  Created by carrot on 24/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation


class RDRequestFactory {
    //MARK:- 书架列表请求
    /**
     书架列表请求
     - returns: RDRequest
     */
    public static func bookShelfRequest() -> RDRequest{
        return RDRequest.init(method: "GET", url: RD_Base_Server_Url + RD_BookShelf_Api, paramters: nil, authorHeader: nil)
    }
    //MARK:- 小说章节列表请求
    /**
     小说章节列表请求
     - parameter novel_id:小说id
     - returns: RDRequest
     */
    public static func novelChapterRequest(novel_id:String) -> RDRequest{
        let params = ["novel_id":novel_id]
        return RDRequest.init(method: "GET", url: RD_Base_Server_Url + RD_NovelChapter_Api, paramters: params, authorHeader: nil)
    }
    
    //MARK:- 具体内容请求
    /**
     小说章节列表请求
     - parameter url:  地址
     - returns: RDRequest
     */
    public static func novelChapterContentRequest(url:String) -> RDRequest{
        return RDRequest.init(method: "GET", url: url, paramters: nil, authorHeader: nil)
    }

    
    
    
    
    
    
}
