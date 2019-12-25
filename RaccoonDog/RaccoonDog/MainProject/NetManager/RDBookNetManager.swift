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
}
