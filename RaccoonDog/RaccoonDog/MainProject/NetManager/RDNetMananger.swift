//
//  RDNetMananger.swift
//  RaccoonDog
//
//  Created by carrot on 22/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation
import Alamofire
typealias RDNetSuccess = (_ response : Any?)->Void
typealias RDNetFailure =  (_ error : Error) -> Void
typealias RequestComplete = (_ response : HTTPURLResponse?,_ result : Result<Any,AFError>) -> Void

typealias RequestContentComplete = (_ response : HTTPURLResponse?,_ result : Result<String,AFError>) -> Void


//typealias RequestStringComplete = (_ data : String)
class RDNetManager:NSObject {
    
    
    static func makeContentRequest(request:RDRequest, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure){
        let requestComplete:RequestContentComplete = { (response,result) in
            var error : AFError?
            if case let .failure(value) = result{ error = value }
            if error != nil {
                let ensureError = NSError.init(domain: error!.localizedDescription, code: response?.statusCode ?? 0, userInfo: nil)
                failure(ensureError)
                return
            }
            if case let .success(value) = result{success(value)}
            
        }
        var httpHeaders : HTTPHeaders?
        if let headers = request.authorHeader {
            httpHeaders = HTTPHeaders.init()
            for (key,value) in headers {
                httpHeaders?.add(name: key, value: value)
            }
        }
        
        var dataRequest : DataRequest?
        switch request.method {
        case "GET":
            dataRequest = AF.request(request.url, method: .get, parameters: request.paramters, encoding: URLEncoding.default, headers: httpHeaders, interceptor: nil)
            break
        case "POST":
            dataRequest = AF.request(request.url, method: .post, parameters: request.paramters, encoding: URLEncoding.default, headers: httpHeaders, interceptor: nil)
            break
        case "DELETE":
            dataRequest = AF.request(request.url, method: .delete, parameters: request.paramters, encoding: URLEncoding.default, headers: httpHeaders, interceptor: nil)
            break
        case "PUT":
            dataRequest = AF.request(request.url, method: .put, parameters: request.paramters, encoding: URLEncoding.default, headers: httpHeaders, interceptor: nil)
            break
        default:
            break
        }
        if let request = dataRequest {
            request.responseString(completionHandler: { (response) in
                requestComplete(response.response,response.result)
            })
        }
        
        
    }
    static func makeRequest(request:RDRequest, success:@escaping RDNetSuccess,failure:@escaping RDNetFailure){
        
        let requestComplete:RequestComplete = { (response,result) in
            var error : AFError?
            if case let .failure(value) = result{ error = value }
            if error != nil {
                let ensureError = NSError.init(domain: error!.localizedDescription, code: response?.statusCode ?? 0, userInfo: nil)
                failure(ensureError)
                return
            }
            if case let .success(value) = result{success(value)}
            
        }
        var httpHeaders : HTTPHeaders?
        if let headers = request.authorHeader {
            httpHeaders = HTTPHeaders.init()
            for (key,value) in headers {
                httpHeaders?.add(name: key, value: value)
            }
        }
        
        var dataRequest : DataRequest?
        
        switch request.method {
        case "GET":
            dataRequest = AF.request(request.url, method: .get, parameters: request.paramters, encoding: URLEncoding.default, headers: httpHeaders, interceptor: nil)
            break
        case "POST":
            dataRequest = AF.request(request.url, method: .post, parameters: request.paramters, encoding: URLEncoding.default, headers: httpHeaders, interceptor: nil)
            break
        case "DELETE":
            dataRequest = AF.request(request.url, method: .delete, parameters: request.paramters, encoding: URLEncoding.default, headers: httpHeaders, interceptor: nil)
            break
        case "PUT":
            dataRequest = AF.request(request.url, method: .put, parameters: request.paramters, encoding: URLEncoding.default, headers: httpHeaders, interceptor: nil)
            break
        default:
            break
        }
        if let request = dataRequest {
            request.responseJSON { (response) in
                requestComplete(response.response, response.result);
            }
            
        }
        
    }
}
