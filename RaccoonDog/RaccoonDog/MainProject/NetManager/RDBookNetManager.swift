//
//  RDBookNetManager.swift
//  RaccoonDog
//
//  Created by carrot on 24/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation
class RDBookNetManager {
    //MARK:- 书架接口
    /**
     - returns:
     */
    public static func bookShelfNetWork(success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.bookShelfRequest()
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 小说章节列表请求
    /**
     小说章节列表请求
     - parameter novel_id:小说id
     - returns: RDRequest
     */
    public static func novelChapterNetWork(novel_id:String, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.novelChapterRequest(novel_id: novel_id)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 章节内容请求
    /**
     小说章节列表请求
     - parameter url:  地址
     - returns: RDRequest
     */
    
    public static func novelChapterContentNetWork(url:String, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.novelChapterContentRequest(url: url)
        RDNetManager.makeContentRequest(request: request, success: success, failure: failure)
    }
    
    
    //MARK:- 书城标题接口
    /**
     书城标题接口
     - returns: RDRequest
     */
    public static func bookStoreNetWork( success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.bookStoreRequest()
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 精选列表接口
    /**
     精选列表接口
     - returns: RDRequest
     */
    public static func bookStoreListNetWork( success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.bookStoreListRequest()
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- banner接口
    /**
     banner接口
     - parameter poster_type:  默认0书柜，1书城，2有声
     - returns: RDRequest
     */
    public static func bookBannerNetwork(_ poster_type:Int = 0, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.bookBannerRequest(poster_type)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 小说详情
    /**
     小说详情
     - parameter book_uuid:  书籍id
     - returns: RDRequest
     */
    public static func bookInfoNetwork(_ book_uuid : String, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.bookInfoRequest(book_uuid)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 推荐
    /**
     推荐接口
     - parameter book_uuid: 书籍id
     - returns: RDRequest
     */
    public static func bookRecommendNetwork(_ book_uuid : String, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.bookRecommendRequest(book_uuid)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 加入书架
    /**
     加入书架
     - parameter book_uuid: 书籍id
     - returns: RDRequest
     */
    public static func addBookSelfNetwork(_ book_uuid : String, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.addBookSelfRequest(book_uuid)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 删除书架
    /**
     删除书架
     - parameter book_uuid: 书籍id
     - returns: RDRequest
     */
    public static func deleteBookSelfNetwork(_ book_uuid : String, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.deleteBookSelfRequest(book_uuid)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 加入收藏
    /**
     加入收藏
     - parameter book_uuid: 书籍id
     - returns: RDRequest
     */
    public static func addCollectionNetwork(_ book_uuid : String, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.addCollectionRequest(book_uuid)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 删除收藏
    /**
     删除收藏
     - parameter book_uuid: 书籍id
     - returns: RDRequest
     */
    public static func deleteCollectionNetwork(_ book_uuid : String, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.deleteCollectionRequest(book_uuid)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 收藏列表
    /**
     收藏列表
     - returns: RDRequest
     */
    public static func collectionListNetwork( success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.collectionListRequest()
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:-  配置接口
    /**
     配置接口
     - returns: RDRequest
     */
    public static func getConfigNetwork( success:@escaping RDNetSuccess,failure:@escaping RDNetFailure) {
        let request = RDRequestFactory.getConfigRequest()
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    
    
    
    
}
