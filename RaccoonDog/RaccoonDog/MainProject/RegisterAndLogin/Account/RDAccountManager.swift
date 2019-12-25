//
//  RDAccountManager.swift
//  RaccoonDog
//
//  Created by carrot on 22/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation
class RDAccount: NSObject,NSSecureCoding {
    static var supportsSecureCoding: Bool = true

    var book_evaluation : Int?
    var check_in_days : Int?
    var user_buckets : Int?
    var user_score : Int?
    var user_status : Int?
    var user_type : Int?
    var mobile : Int?

    var created_at : String?
    let id : Int!
    var ip_login : String?
    var ip_register : String?
    var mobile_pre : String?
    var nickname : String?
    var p_utm : String?
    var pp_utm : String?
    var read_time : Int?
    var sex : String?
    let token : String!
    var updated_at : String?
    var utm : String?

    
    public static func getAccount(data:Any?) -> RDAccount?{
        guard let item = data as? Dictionary<String,Any>,let id = item["id"] as? Int, let token = item["token"] as? String  else{
            return nil
        }
        let account = RDAccount.init(id: id, token: token)
        if let book_evaluation = item["book_evaluation"] as? Int {
            account.book_evaluation = book_evaluation
        }
        if let check_in_days = item["check_in_days"] as? Int {
            account.check_in_days = check_in_days
        }
        if let user_buckets = item["user_buckets"] as? Int {
            account.user_buckets = user_buckets
        }
        if let user_score = item["user_score"] as? Int {
            account.user_score = user_score
        }
        if let user_status = item["user_status"] as? Int {
            account.user_status = user_status
        }
        if let user_type = item["user_type"] as? Int {
            account.user_type = user_type
        }
        if let read_time = item["read_time"] as? Int {
            account.read_time = read_time
        }
        if let mobile = item["mobile"] as? Int {
            account.mobile = mobile
        }
        if let created_at = item["created_at"] as? String {
            account.created_at = created_at
        }
        if let ip_login = item["ip_login"] as? String {
            account.ip_login = ip_login
        }
        
        

        if let ip_register = item["ip_register"] as? String {
            account.ip_register = ip_register
        }

        if let mobile_pre = item["mobile_pre"] as? String {
            account.mobile_pre = mobile_pre
        }
        if let nickname = item["nickname"] as? String {
            account.nickname = nickname
        }
        if let p_utm = item["p_utm"] as? String {
            account.p_utm = p_utm
        }

        if let sex = item["sex"] as? String {
            account.sex = sex
        }
        if let updated_at = item["updated_at"] as? String {
            account.updated_at = updated_at
        }
        if let utm = item["utm"] as? String {
            account.utm = utm
        }
        return account
        
    }

    public init(id : Int,token :String) {
        self.id = id
        self.token = token
        super.init()
    }
    
    


    func encode(with aCoder: NSCoder) {
        aCoder.encode(book_evaluation, forKey: "book_evaluation")
        aCoder.encode(check_in_days, forKey: "check_in_days")
        aCoder.encode(created_at, forKey: "created_at")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(ip_login, forKey: "ip_login")
        aCoder.encode(ip_register, forKey: "ip_register")
        aCoder.encode(mobile, forKey: "mobile")
        aCoder.encode(mobile_pre, forKey: "mobile_pre")
        aCoder.encode(nickname, forKey: "nickname")
        aCoder.encode(p_utm, forKey: "p_utm")
        aCoder.encode(pp_utm, forKey: "pp_utm")
        aCoder.encode(read_time, forKey: "read_time")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(updated_at, forKey: "updated_at")
        aCoder.encode(user_buckets, forKey: "user_buckets")
        aCoder.encode(user_score, forKey: "user_score")
        aCoder.encode(user_status, forKey: "user_status")
        aCoder.encode(user_type, forKey: "user_type")
        aCoder.encode(utm, forKey: "utm")

        

    }
    
    
//0
    required init?(coder deCoder: NSCoder) {
        book_evaluation = deCoder.decodeObject(forKey: "book_evaluation") as? Int
        check_in_days = (deCoder.decodeObject(forKey: "check_in_days") as? Int)
        created_at = deCoder.decodeObject(forKey: "created_at") as? String
        id = deCoder.decodeObject(forKey: "id") as? Int ?? 0
        user_buckets = deCoder.decodeObject(forKey: "user_buckets") as? Int
        user_score = deCoder.decodeObject(forKey: "user_score") as? Int
        user_status = deCoder.decodeObject(forKey: "user_status") as? Int
        user_type = deCoder.decodeObject(forKey: "user_type") as? Int
        mobile = deCoder.decodeObject(forKey: "mobile") as? Int
        ip_login = deCoder.decodeObject(forKey: "ip_login") as? String
        ip_register = deCoder.decodeObject(forKey: "ip_register") as? String
        mobile_pre = deCoder.decodeObject(forKey: "mobile_pre") as? String
        nickname = deCoder.decodeObject(forKey: "nickname") as? String
        p_utm = deCoder.decodeObject(forKey: "p_utm") as? String
        pp_utm = deCoder.decodeObject(forKey: "pp_utm") as? String
        read_time = deCoder.decodeObject(forKey: "read_time") as? Int
        sex = deCoder.decodeObject(forKey: "sex") as? String
        token = deCoder.decodeObject(forKey: "token") as? String
        updated_at = deCoder.decodeObject(forKey: "updated_at") as? String
        utm = deCoder.decodeObject(forKey: "utm") as? String

    }
    
}



class RDAccountManager:NSObject{
    
    static let share = RDAccountManager.init()
    private var currentAccount : RDAccount?
    private var accountPath : String?
    private override init(){
        super.init()
    }
    //获取当前用户
    open func localAccount() -> RDAccount? {
        if currentAccount != nil {
            return currentAccount
        }
        guard var path = self.getAccountDirectory() else {
            return nil
        }
        
        path = "\(path)/localAccount"
        
        if FileManager.default.fileExists(atPath: path) {
            if  let account =  NSKeyedUnarchiver.unarchiveObject(withFile: path) as? RDAccount{
                self.currentAccount  = account
                return account
            }
            return nil
        }
        return nil
    }
    
    
    func getAccountDirectory() -> String?{
        if let path = self.accountPath {
            return path
        }
        guard var  path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else{
            return nil
        }
        path =  "\(path)/RaccoonDog_Account_Directory";
        if FileManager.default.fileExists(atPath: path) {
        }else{
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch  {
                MyLog(error.localizedDescription)
            }
        }
        self.accountPath = path;
        return path;
    }
    
    func saveCurrentAccount(account:RDAccount) {
        guard var path = self.getAccountDirectory() else {
            return
        }
        path = "\(path)/localAccount"
        let success =  NSKeyedArchiver.archiveRootObject(account, toFile: path)
        if !success {
            MyLog("保存失败")
        }
    }
    
    
}

class RDAccountRequest{
    //MARK:- 注册请求
    /**
     注册请求
     - parameter phoneNumber: 手机号
     - parameter code: 验证码
     - parameter E164: 国家电话代号 如：86
     - parameter password: 密码

     - returns: 返回request
     */
    static func registerRequest(phoneNumber:String,code:String,E164:String,password:String?) -> RDRequest{
        let params : Dictionary<String,Any>
        if let pass = password {
            params = ["mobile":phoneNumber,"mobile_pre":E164,"password":pass,"code":code]
        }else
        {
            params = ["mobile":phoneNumber,"mobile_pre":E164,"code":code]
        }
        let request = RDRequest.init(method: "POST", url: RD_Base_Server_Url + RD_Register_Api, paramters: params, authorHeader: nil)
        return request
    }
    
    //MARK:- 发送短信请求
    /**
     发送短信请求
     - parameter phoneNumber: 手机号
     - parameter E164: 国家电话代号 如：86
     - returns: 返回request
     */
    static func sendSMSRequest(phoneNumber:String,E164:String) -> RDRequest{
        let params = ["mobile":phoneNumber,"mobile_pre":E164]
        let request = RDRequest.init(method: "GET", url: RD_Base_Server_Url + RD_SendSMS_Api, paramters: params, authorHeader: nil)
        return request
    }
    //MARK:- 登录请求
    /**
      登录请求
     - parameter phoneNumber: 手机号
     - parameter E164: 国家电话代号 如：86
     - parameter password: 密码
     - returns: 返回request
     */
    static func loginRequest(phoneNumber:String,E164:String,password:String) -> RDRequest{
        let params = ["mobile":phoneNumber,"mobile_pre":E164,"password":password]
        let request = RDRequest.init(method: "POST", url: RD_Base_Server_Url + RD_Login_Api, paramters: params, authorHeader: nil)
        return request
    }

    
    
    
}

extension RDAccountManager {
    
    
    //MARK:- 注册接口
    /**
     注册接口
     - parameter request: 请求
     - parameter success: 成功回调
     - parameter failure: 失败回调

     - returns: Void
     */
    static func registerNetWork(phoneNumber:String,code:String,E164:String,password:String?,success:@escaping RDNetSuccess,failure:@escaping RDNetFailure){
        let request = RDAccountRequest.registerRequest(phoneNumber: phoneNumber, code: code, E164: E164, password: password)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:- 发送短信接口
    /**
     发送短信接口
     - parameter request: 请求
     - parameter success: 成功回调
     - parameter failure: 失败回调

     - returns: Void
     */
    static func SendSMSNetWork(phoneNumber:String,E164:String,success:@escaping RDNetSuccess,failure:@escaping RDNetFailure){
        let request = RDAccountRequest.sendSMSRequest(phoneNumber: phoneNumber, E164: E164)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
    //MARK:-  登录接口
    /**
     登录接口
     - parameter request: 请求
     - parameter success: 成功回调
     - parameter failure: 失败回调

     - returns: Void
     */
    static func loginNetWork(phoneNumber:String,E164:String,password:String,success:@escaping RDNetSuccess,failure:@escaping RDNetFailure){
        let request = RDAccountRequest.loginRequest(phoneNumber: phoneNumber, E164: E164, password: password)
        RDNetManager.makeRequest(request: request, success: success, failure: failure)
    }
}
