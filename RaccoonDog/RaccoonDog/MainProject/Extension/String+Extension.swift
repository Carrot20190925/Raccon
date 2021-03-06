//
//  String+Extension.swift
//  DZMeBookRead
//
//  Created by dengzemiao on 2019/4/17.
//  Copyright © 2019年 DZM. All rights reserved.
//

import UIKit
import CommonCrypto
extension String {
    
    var length:Int { return (self as NSString).length }
    
    var bool:Bool { return (self as NSString).boolValue }
    
    var integer:NSInteger { return (self as NSString).integerValue }
    
    var float:Float { return (self as NSString).floatValue }
    
    var cgFloat:CGFloat { return CGFloat(self.float) }
    
    var double:Double { return (self as NSString).doubleValue }
    
    /// 文件后缀(不带'.')
    var pathExtension:String { return (self as NSString).pathExtension }
    
    /// 文件名(带后缀)
    var lastPathComponent:String { return (self as NSString).lastPathComponent }
    
    /// 文件名(不带后缀)
    var deletingPathExtension:String { return (self as NSString).deletingPathExtension }
    
    /// 去除首尾空格
    var removeSpaceHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespaces) }
    
    /// 去除首尾换行
    var removeEnterHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespaces) }
    
    /// 去除首尾空格和换行
    var removeSEHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) }
    
    /// 去掉所有空格
    var removeSapceAll:String { return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "　", with: "") }
    
    /// 去除所有换行
    var removeEnterAll:String { return replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "") }
    
    /// 去除所有空格换行
    var removeSapceEnterAll:String { return removeSapceAll.replacingOccurrences(of: "\n", with: "") }
    
    /// 是否为整数
    var isInt:Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    /// 是否为数字或Float
    var isFloat:Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Float = 0
        
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    
    /// 是否为空格
    var isSpace:Bool {
        
        if (self == " ") || (self == "　") { return true }
        
        return false
    }
    
    /// 是否为空格或者回车
    var isSpaceOrEnter:Bool {
        
        if isSpace || (self == "\n") { return true }
        
        return false
    }
    
    /// MD5加密
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    
    /// 转JSON
    var json:Any? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        
        return json
    }
    
    /// 是否包含指定字符串
    func range(_ string: String) ->NSRange {
        
        return (self as NSString).range(of: string)
    }
    
    /// 截取字符串
    func substring(_ range:NSRange) ->String {
        
        return (self as NSString).substring(with: range)
    }
    
    /// 处理带中文的字符串
    func addingPercentEncoding(_ characters: CharacterSet = .urlQueryAllowed) ->String {
        
        return (self as NSString).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    /// 正则替换字符
    func replacingCharacters(_ pattern:String, _ template:String) ->String {
        
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            return regularExpression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, length), withTemplate: template)
            
        } catch {return self}
    }
    
    /// 正则搜索相关字符位置
    func matches(_ pattern:String) ->[NSTextCheckingResult] {
        
        if isEmpty {return []}
        
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            return regularExpression.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, length))
            
        } catch {return []}
    }
    
    /// 计算大小
    func size(_ font:UIFont, _ size:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) ->CGSize {
        
        let string:NSString = self as NSString
        
        return string.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [.font:font], context: nil).size
    }
    private func twoSpace() ->String{
        return "\u{3000}\u{3000}"
    }
    func formatContent() -> String {
        var string = self.replacingOccurrences(of: "\r", with: "")
        string = string.replacingOccurrences(of: " ", with: "")
        string = string.replacingOccurrences(of: "\u{3000}", with: "")
        string = string.replacingOccurrences(of: "\t", with: "")
        string = string.replacingOccurrences(of: "\n\n\n\n\n", with: "\n")
        string = string.replacingOccurrences(of: "\n\n\n\n", with: "\n")
        string = string.replacingOccurrences(of: "\n\n\n", with: "\n")
        string = string.replacingOccurrences(of: "\n\n", with: "\n")
        string = string.replacingOccurrences(of: "\n", with: "\n\(self.twoSpace())")
        string = "\(self.twoSpace())\(string)"
        return string
    }
}

extension NSAttributedString {
    
    /// 计算size
    func size(_ size:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) ->CGSize{
        
        return self.boundingRect(with: size, options: [NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading], context: nil).size
    }
    
    /// 扩展拼接
    func add<T:NSAttributedString>(_ string:T) ->NSAttributedString {
        
        let attributedText = NSMutableAttributedString(attributedString: self)
        
        attributedText.append(string)
        
        return attributedText
    }
}
