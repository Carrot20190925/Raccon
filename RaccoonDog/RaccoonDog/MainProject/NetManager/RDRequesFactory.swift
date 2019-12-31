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
        let params = ["book_uuid":novel_id]
        return RDRequest.init(method: "GET", url: RD_Base_Server_Url + RD_NovelChapter_Api, paramters: params, authorHeader: nil)
    }
    
    //MARK:- 具体内容请求
    /**
     具体内容请求
     - parameter url:  地址
     - returns: RDRequest
     */
    public static func novelChapterContentRequest(url:String) -> RDRequest{
        return RDRequest.init(method: "GET", url: url, paramters: nil, authorHeader: nil)
    }
    
    
    //MARK:- 书城标题接口
    /**
     书城标题接口
     - returns: RDRequest
     */
    public static func bookStoreRequest() -> RDRequest{
        return RDRequest.init(method: "GET", url: RD_Base_Server_Url + RD_BookStore_Title_Api, paramters: nil, authorHeader: nil)
    }
    
    //MARK:- 精选列表接口
    /**
     精选列表接口
     - returns: RDRequest
     */
    public static func bookStoreListRequest() -> RDRequest{
        return RDRequest.init(method: "GET", url: RD_Base_Server_Url + RD_BookStore_Bookshop_Api, paramters: nil, authorHeader: nil)
    }
    
    //MARK:- banner接口
    /**
     banner接口
     - parameter poster_type:  默认0书柜，1书城，2有声
     - returns: RDRequest
     */
    public static func bookBannerRequest(_ poster_type:Int = 0) -> RDRequest{
        let params = ["poster_type":poster_type]
        return RDRequest.init(method: "GET", url: RD_Base_Server_Url + RD_Banner_Api, paramters: params, authorHeader: nil)
    }
    
    //MARK:- 小说详情
    /**
     小说详情
     - parameter book_uuid: 书籍id
     - returns: RDRequest
     */
    public static func bookInfoRequest(_ book_uuid : String) -> RDRequest{
        let params = ["book_uuid":book_uuid]
        return RDRequest.init(method: "GET", url: RD_Base_Server_Url + RD_NovelInfo_Api, paramters: params, authorHeader: nil)
    }
    
    //MARK:- 推荐
    /**
     推荐接口
     - parameter book_uuid: 书籍id
     - returns: RDRequest
     */
    public static func bookRecommendRequest(_ book_uuid : String) -> RDRequest{
        let params = ["book_uuid":book_uuid]
        return RDRequest.init(method: "GET", url: RD_Base_Server_Url + RD_Recommend_Api, paramters: params, authorHeader: nil)
    }
    


    
    
    
    
    
    
}
