//
//  ContentMananger.swift
//  RaccoonDog
//
//  Created by carrot on 25/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation
class ContentManager {
    
    var contentCache : NSCache = NSCache<AnyObject, AnyObject>()
    var contentPath : String?
    static let share = ContentManager.init()
    
    private init(){}
    func getContent(chapter_no:Int,novel_id:String) -> String? {
        
        let key = "\(novel_id)_\(chapter_no)"
        if let content = self.contentCache.object(forKey: key as AnyObject) as? String,content.count > 1 {
            return content
        }
        if var path = self.getContentPath(){
            path = "\(path)/\(novel_id)/\(key)"
            if FileManager.default.fileExists(atPath: path) {
                if  let content = try? String.init(contentsOfFile: path, encoding: .utf8),content.count > 1{
                    self.contentCache.setObject(content as AnyObject, forKey: key as AnyObject)
                    return content
                }
                return nil
            }
            return nil
        }
        return nil
    }
    
    func saveContent(chapter_no:Int,novel_id:String,content:String) {
        let key = "\(novel_id)_\(chapter_no)"
        self.contentCache.setObject(content as AnyObject, forKey: key as AnyObject)
        DispatchQueue.global().async {
            if var path = self.getContentPath() {
                path = "\(path)/\(novel_id)"
                if !FileManager.default.fileExists(atPath: path) {
                    try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                }
                if let data = content.data(using: .utf8){
                    path = "\(path)/\(key)"
                    let success =  FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
                    if !success{
                        MyLog("保存内容失败")
                    }
                }
            }
        }
    }
    
    
    private func getContentPath () -> String?{
        if let path = self.contentPath {
            return path
        }
        guard var  path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else{
            return nil
        }
        path =  "\(path)/Content";
        if FileManager.default.fileExists(atPath: path) {
        }else{
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch  {
                MyLog(error.localizedDescription)
            }
        }
        self.contentPath = path;
        return path;
    }
    
}

