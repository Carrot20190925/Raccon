//
//  RD_DBManager.swift
//  RaccoonDog
//
//  Created by carrot on 25/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation
import FMDB

typealias DatabaseHandle = ((_ data : Any) -> Void)
let rd_database_queue = "rd_database_queue_serial"
let rd_create_novel_list_table_sql = "create table if not exists novel_list (novel_chapter_id text primary key,chapter_content text,chapter_no int,chapter_title text,created_at text,chapter_id int,novel_id text ,volume int,isRead bool,isCurrentRead bool)"



class RD_DBManager {
    
    var databasePath : String?
    var dbQueue : FMDatabaseQueue?
    var db : FMDatabase?
    static let share = RD_DBManager.init()
    private init(){
        self.initTables()
    }
    private func getDatabasePath () -> String?{
        if let path = self.databasePath {
            return path
        }
        guard var  path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else{
            return nil
        }
        path =  "\(path)/RD_Database";
        if FileManager.default.fileExists(atPath: path) {
        }else{
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch  {
                MyLog(error.localizedDescription)
            }
        }
        self.databasePath = path;
        return path;
    }
    
    //MARK:-  初始化数据库
    private func getDBQueue() -> FMDatabaseQueue?{
        if let queue = self.dbQueue {
            return queue
        }
        if var path = self.getDatabasePath(){
            path = "\(path)/database.sqlite"
            let queue = FMDatabaseQueue.init(path: path)
            self.dbQueue = queue
            return queue;
        }
        return nil
    }
    
    private func getDB() -> FMDatabase?{
        if let db = self.db {
            db.open()
            return db
        }
        if var path = self.getDatabasePath(){
            path = "\(path)/database.sqlite"
            let db = FMDatabase.init(path: path)
            db.open()
            self.db = db
            return db;
        }
        return nil
    }
    
    //MARK:-  初始化表
    private func initTables(){
        if let queue = self.getDBQueue(){
            queue.inDatabase { (db) in
               try? db.executeUpdate(rd_create_novel_list_table_sql, values: nil)
            }
        }
    }
    
    
    
    //MARK:-  插入数据
    func updateNovelList(data : Any?) {
        if let items = data as? Array <Dictionary <String,Any>> {
            self.updateModels(datas: items)
        }else if let item = data as? Dictionary<String,Any>{
            self.updateModel(item: item)
        }else{
            MyLog("数据不正常")
        }
    }
    
    private func updateModel(item : Dictionary<String,Any>){
        self.getDBQueue()?.inTransaction({ (db, stop) in
            guard let chapter_no = item["chapter_no"] as? Int,let novel_id = item["book_uuid"] as? String else {
                return
            }
            let novel_chapter_id = "\(novel_id)\(chapter_no)"
            let sql = "SELECT * FROM novel_list where novel_chapter_id = ? ;"

            let chapter_content = item["chapter_content"] as? String
            let chapter_title = item["chapter_title"] as? String
            let created_at = item["created_at"] as? String
            let id = item["id"] as? Int
            let volume = item["volume"] as? Int
            let isRead = item["isRead"] as? Bool
            let isCurrentRead = item["isCurrentRead"] as? Bool
            if  let result = try? db.executeQuery(sql, values: [novel_chapter_id]){
                if result.next(){
                    let sql = "update novel_list set chapter_id = \(id ?? 0),novel_id = \(novel_id),chapter_content = \(chapter_content ?? ""),chapter_title = \(chapter_title ?? ""),created_at = \(created_at ?? ""),volume = \(volume ?? 0),chapter_no = \(chapter_no),isRead = \(isRead ?? false),isCurrentRead = \(isCurrentRead ?? false) where novel_chapter_id = \(novel_chapter_id) ;"
                    db.executeUpdate(sql, withArgumentsIn: [])
                }else{
                    let sql = "insert into novel_list (novel_chapter_id,chapter_id,novel_id,chapter_content,chapter_title,created_at,volume,chapter_no,isRead,isCurrentRead) values(?,?,?,?,?,?,?,?,?,?) ;"
                    db.executeUpdate(sql, withArgumentsIn: [novel_chapter_id,id ?? 0,novel_id,chapter_content ?? "",chapter_title ?? "",created_at ?? "",volume ?? 0,chapter_no,isRead ?? false,isCurrentRead ?? false])
                }
            }else{
                let sql = "insert into novel_list (novel_chapter_id,chapter_id,novel_id,chapter_content,chapter_title,created_at,volume,chapter_no,isRead,isCurrentRead) values(?,?,?,?,?,?,?,?,?,?) ;"
                db.executeUpdate(sql, withArgumentsIn: [novel_chapter_id,id ?? 0,novel_id,chapter_content ?? "",chapter_title ?? "",created_at ?? "",volume ?? 0,chapter_no,isRead ?? false,isCurrentRead ?? false])
            }
        })
    }
    
    private func updateModels(datas : Array<Dictionary <String,Any>>){
        self.getDBQueue()?.inTransaction({ (db, stop) in
            for item in datas{
                
                guard let chapter_no = item["chapter_no"] as? Int,let novel_id = item["book_uuid"] as? String else {
                    continue
                }
                
                let novel_chapter_id = "\(novel_id)\(chapter_no)"
                let sql = "SELECT * FROM novel_list where novel_chapter_id = ? ;"

                let chapter_content = item["chapter_content"] as? String
                let chapter_title = item["chapter_title"] as? String
                let created_at = item["created_at"] as? String
                let id = item["id"] as? Int
                let volume = item["volume"] as? Int
                
                if  let result = try? db.executeQuery(sql, values: [novel_chapter_id]){
                    if result.next(){
                        let sql = "update novel_list set chapter_id = \(id ?? 0),novel_id = \(novel_id),chapter_content = \(chapter_content ?? ""),chapter_title = \(chapter_title ?? ""),created_at = \(created_at ?? ""),volume = \(volume ?? 0),chapter_no = \(chapter_no) where novel_chapter_id = \(novel_chapter_id) ;"
                        db.executeUpdate(sql, withArgumentsIn: [])
                    }else{
                        let sql = "insert into novel_list (novel_chapter_id,chapter_id,novel_id,chapter_content,chapter_title,created_at,volume,chapter_no) values(?,?,?,?,?,?,?,?) ;"
                        db.executeUpdate(sql, withArgumentsIn: [novel_chapter_id,id ?? 0,novel_id,chapter_content ?? "",chapter_title ?? "",created_at ?? "",volume ?? 0,chapter_no])
                    }
                }else{
                    let sql = "insert into novel_list (novel_chapter_id,chapter_id,novel_id,chapter_content,chapter_title,created_at,volume,chapter_no) values(?,?,?,?,?,?,?,?) ;"
                    db.executeUpdate(sql, withArgumentsIn: [novel_chapter_id,id ?? 0,novel_id,chapter_content ?? "",chapter_title ?? "",created_at ?? "",volume ?? 0,chapter_no])
                }
            }
            
        })
    }
    
    
    static func getSyncNovelList(novel_id : String) -> [Any]?{
        let sql = "select * from novel_list where novel_id = \(novel_id)"
        if let result = RD_DBManager.share.getDB()?.executeQuery(sql, withArgumentsIn: []){
            var datas : [Dictionary <String,Any?>] = []
            while result.next(){
                let novel_id = result.string(forColumn: "novel_id")
                let id = result.long(forColumn: "chapter_id")
                let chapter_no = result.long(forColumn: "chapter_no")
                let chapter_content = result.string(forColumn: "chapter_content")
                let chapter_title = result.string(forColumn: "chapter_title")
                let created_at = result.string(forColumn: "created_at")
                let volume = result.long(forColumn: "volume")
                let isRead = result.bool(forColumn: "isRead")
                let isCurrentRead = result.bool(forColumn: "isCurrentRead")
                
                let data = ["book_uuid":novel_id,
                            "id":id,
                            "chapter_no":chapter_no,
                            "chapter_content":chapter_content,
                            "chapter_title":chapter_title,
                            "created_at":created_at,
                            "volume":volume,
                            "isRead":isRead,
                            "isCurrentRead":isCurrentRead
                    ] as [String : Any?]
                datas.append(data)
            }
            return datas
        }
        return nil

    }
    
    //MARK:-  获取数据
    static func getNovelList(novel_id : String,complete:@escaping DatabaseHandle){
        RD_DBManager.share.getDBQueue()?.inTransaction({ (db, stop) in
            let sql = "select * from novel_list where novel_id = \(novel_id)"
            let result = db.executeQuery(sql, withArgumentsIn: [])
            var datas : [Dictionary <String,Any?>] = []
            while result?.next() ?? false{
                let novel_id = result!.string(forColumn: "novel_id")
                let id = result!.long(forColumn: "chapter_id")
                let chapter_no = result!.long(forColumn: "chapter_no")
                let chapter_content = result!.string(forColumn: "chapter_content")
                let chapter_title = result!.string(forColumn: "chapter_title")
                let created_at = result!.string(forColumn: "created_at")
                let volume = result!.long(forColumn: "volume")
                let isRead = result!.bool(forColumn: "isRead")
                let isCurrentRead = result!.bool(forColumn: "isCurrentRead")
                
                let data = ["book_uuid":novel_id,
                            "id":id,
                            "chapter_no":chapter_no,
                            "chapter_content":chapter_content,
                            "chapter_title":chapter_title,
                            "created_at":created_at,
                            "volume":volume,
                            "isRead":isRead,
                            "isCurrentRead":isCurrentRead
                    ] as [String : Any?]
                datas.append(data)
            }
            complete(datas)
        })
    }
    
    
}
