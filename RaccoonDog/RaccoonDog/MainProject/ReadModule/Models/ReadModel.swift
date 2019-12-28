//
//  ReadModel.swift
//  RaccoonDog
//
//  Created by carrot on 25/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation

let RD_Read_ContentY : CGFloat = 40
let RD_Read_ContentX : CGFloat = 15
let RD_Read_Width = rScreenWidth - RD_Read_ContentX * 2
let RD_Read_Height = rScreenHeight - RD_Read_ContentY - 30


let RD_READ_BOOK_HOME_PAGE = -1

class ReadModel {
    var book_uuid : String!
    var bookName : String?
    var bookAuthor : String?
    var bookCategoryId : Int?
    
    
    var currentReadModel : ParserReadModel!{
        didSet{

            
            if listModels.count == 0 {
                return
            }
            let index = currentReadModel.index.intValue
            let models = listModels
            if index > 0,let pre = models[index - 1] as NovelChapterModel?{
                if currentReadModel.previousModel == nil {
                    let preModel = ParserReadModel.getModel(url: pre.chapter_content, chapter_no: pre.chapter_no, novel_id: pre.novel_id, title: pre.chapter_title)
                    preModel.index = NSNumber.init(value: index - 1)
                    currentReadModel.previousModel = preModel
                }

            }
            if (index + 1) < (models.count),let next = models[index + 1] as NovelChapterModel?{
                if currentReadModel.nextModel == nil {
                    let nextModel = ParserReadModel.getModel(url: next.chapter_content, chapter_no: next.chapter_no, novel_id: next.novel_id, title: next.chapter_title)
                    nextModel.index = NSNumber.init(value: index + 1)
                    currentReadModel.nextModel = nextModel
                }

            }
        }
    }
    var listModels : [NovelChapterModel] = []
    
    init(book_uuid:String) {
        self.book_uuid = book_uuid
        self.getCurrentModel()
    }
    
    func setListModels(models : [NovelChapterModel]) {
        listModels = models
        if currentReadModel != nil {
            return;
        }
        for (index,item) in models.enumerated(){
            if item.isCurrentRead {
                let currentModel = ParserReadModel.getModel(url: item.chapter_content, chapter_no: item.chapter_no, novel_id: item.novel_id, title: item.chapter_title)
                currentModel.index = NSNumber.init(value: index) 
                self.currentReadModel = currentModel

                return
            }
        }
        if let item = models.first{
            item.isRead = true
            item.isCurrentRead = true
            item.save()
            let currentModel = ParserReadModel.getModel(url: item.chapter_content, chapter_no: item.chapter_no, novel_id : item.novel_id, title: item.chapter_title)
            currentModel.index = 0
            self.currentReadModel = currentModel

        }
    }
    
    func getCurrentModel() {
        if let recodeModel = DZMKeyedArchiver.unarchiver(folderName: "\(self.book_uuid!)", fileName: "\(self.book_uuid!)") as? ParserReadModel{
            self.currentReadModel = recodeModel
        }
    }
    
}


class ParserReadModel:NSObject,NSSecureCoding,NSCopying {

    static var supportsSecureCoding: Bool = true
    
    var novel_id  : String!
    var index  = NSNumber.init(value: 0)
    var chpater_no = NSNumber.init(value: 0)
    var pageModels : [RDReadPageModel] = []
    var url : String?
    var location : NSNumber = NSNumber.init(value: 0)
    
    var page = NSNumber.init(value: 0)
    //上一章
    var previousModel : ParserReadModel?
    //下一章
    var nextModel : ParserReadModel?
    //章节标题
    var title : String?
    
    var fullAttrText : NSAttributedString?
    
    var ranges : [NSRange] = []
    
    
    var fullText : String?
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        let item = ParserReadModel.init(novel_id: self.novel_id, chapter_no: self.chpater_no.intValue, url: self.url)

        item.index = self.index
        item.title = self.title
        item.page = self.page
        item.fullText = self.fullText
        item.previousModel = self.previousModel
        item.nextModel = self.nextModel
        item.pageModels = self.pageModels
        item.ranges = self.ranges
        item.location = self.location
        return item
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(novel_id, forKey: "novel_id")
        coder.encode(index, forKey: "index")
        coder.encode(chpater_no, forKey: "chpater_no")
        coder.encode(url, forKey: "url")
        coder.encode(previousModel, forKey: "previousModel")
        coder.encode(nextModel, forKey: "nextModel")
        coder.encode(title, forKey: "title")
        coder.encode(fullText, forKey: "fullText")
        coder.encode(location, forKey: "location")
        coder.encode(page, forKey: "page")


    }
    
    required init?(coder: NSCoder) {
        novel_id = coder.decodeObject(forKey: "novel_id") as? String
        index = coder.decodeObject(forKey: "index") as? NSNumber ?? 0
        chpater_no = coder.decodeObject(forKey: "chpater_no") as? NSNumber ?? 0
        url = coder.decodeObject(forKey: "url") as? String
        previousModel = coder.decodeObject(forKey: "previousModel") as? ParserReadModel
        nextModel = coder.decodeObject(forKey: "nextModel") as? ParserReadModel
        title = coder.decodeObject(forKey: "title") as? String
        fullText = coder.decodeObject(forKey: "fullText") as? String
        location = coder.decodeObject(forKey: "location") as? NSNumber ?? NSNumber.init(value: 0)
        page = coder.decodeObject(forKey: "page") as? NSNumber ?? 0

        super.init()
        self.parserModel()
    }
    
    
    
    

    

    
    //MARK:-  前一页
    func previousPage(){
        if page.intValue > 0 {
            page = NSNumber.init(value: page.intValue - 1)
        }
    }
    //MARK:-  后一页
    func nextPage() {
        if page.intValue < (pageModels.count - 1) {
            page = NSNumber.init(value:  page.intValue + 1)
        }
    }
    
    
    
    ///是否是第一章
    var isFirstChapter : Bool {
        return index == 0 || previousModel == nil
    }
    
    var isLastChater : Bool {
        return nextModel == nil
    }
    
    
    
    
    ///是否是第一页
    var isFirstPage : Bool {
         return page == 0
    }
    
    ///是否是最后一页
    var isLastPage : Bool! { return (pageModels.count == 0 || page.intValue == pageModels.count - 1) }
    

    
    func setFullText(fullText: String) {
        self.fullText = fullText
        self.parserModel()

    }
    
    private init(novel_id : String,chapter_no:Int,url:String?) {
        self.novel_id = novel_id
        self.chpater_no = NSNumber.init(value: chapter_no)
        self.url = url

        
    }
    
    static func getModel(url:String?,chapter_no : Int,novel_id : String,title:String?) -> ParserReadModel{
        let  model = ParserReadModel.init(novel_id: novel_id, chapter_no: chapter_no, url: url)
        model.title = title
        if let content = ContentManager.share.getContent(chapter_no: chapter_no, novel_id:novel_id){
            model.setFullText(fullText: content)
        }else{
            if let urlString = url{
                RDBookNetManager.novelChapterContentNetWork(url:RD_Base_Server_Url + "/TestNovelContent", success: { (response) in
                    if let content = response as? String{
                        model.setFullText(fullText: content)
                        ContentManager.share.saveContent(chapter_no: chapter_no, novel_id: novel_id, content: content)
                    }
                    MyLog(response)
                    
                }) { (error) in
                    MyLog(error)
                }
            }
        }
        return model;
    }
    
    //MARK:-  //解析数据
    
    func parserModel() {

        let fullAttr = fullContentAttrString()
        fullAttrText = fullAttr
        let rect = CGRect.init(x: 0, y: 0, width: DZM_READ_VIEW_RECT.size.width, height: DZM_READ_VIEW_RECT.size.height)
        let ranges = DZMCoreText.GetPageingRanges(attrString: fullAttr, rect: rect  )
        self.pageModels.removeAll()
        if !ranges.isEmpty {
            self.pageModels = self.pageing(attrString: fullAttr, rect: rect, isFirstChapter: index == 0)
        }
        
    }
    
    
    // MARK: -- 内容分页
    
    /// 内容分页
    ///
    /// - Parameters:
    ///   - attrString: 内容
    ///   - rect: 显示范围
    ///   - isFirstChapter: 是否为本文章第一个展示章节,如果是则加入书籍首页。(小技巧:如果不需要书籍首页,可不用传,默认就是不带书籍首页)
    /// - Returns: 内容分页列表
    func pageing(attrString:NSAttributedString, rect:CGRect, isFirstChapter:Bool = false) ->[RDReadPageModel] {
        
        var pageModels:[RDReadPageModel] = []
//        
//        if isFirstChapter { // 第一页为书籍页面
//            
//            let pageModel = RDReadPageModel()
//            
//            pageModel.range = NSMakeRange(RD_READ_BOOK_HOME_PAGE, 1)
//            
//            pageModel.contentSize = DZM_READ_VIEW_RECT.size
//            
//            pageModels.append(pageModel)
//        }
        
        let ranges = DZMCoreText.GetPageingRanges(attrString: attrString, rect: rect)
        
        if !ranges.isEmpty {
            self.ranges = ranges
            let count = ranges.count

            for i in 0..<count {
                
                let range = ranges[i]
                if location.intValue >= range.location,location.intValue <= range.location + range.length  {
                    self.page = NSNumber.init(value: i)
                }
                let pageModel = RDReadPageModel()
                
                let content = attrString.attributedSubstring(from: range)
                
                pageModel.range = range
                
                pageModel.content = content
                
                pageModel.page = i
                
                // --- (滚动模式 || 长按菜单) 使用 ---
                
                // 注意: 为什么这些数据会放到这里赋值，而不是封装起来， 原因是 contentSize 计算封装在 pageModel内部计算出现宽高为0的情况，所以放出来到这里计算，原因还未找到，但是放到这里计算就没有问题。封装起来则会出现宽高度不计算的情况。
                
                // 内容Size (滚动模式 || 长按菜单)
                let maxW = DZM_READ_VIEW_RECT.width
                
                pageModel.contentSize = CGSize(width: maxW, height: DZMCoreText.GetAttrStringHeight(attrString: content, maxW: maxW))
                

                
                // --- (滚动模式 || 长按菜单) 使用 ---
                
                pageModels.append(pageModel)
            }
        }
        
        return pageModels
    }
    
    /// 完整内容排版
    private func fullContentAttrString() ->NSMutableAttributedString {
        
        let titleString = NSMutableAttributedString(string: "\(title ?? "无题")\n" , attributes: ReadConfigModel.shared().attributes(isTitle: true))
        let contentString = NSMutableAttributedString(string: fullText ?? "无内容", attributes: ReadConfigModel.shared().attributes(isTitle: false))
        titleString.append(contentString)
        
        return titleString
    }
    
    
    
    
    
    func save() {
        //记录阅读位置
        if page.intValue < (self.ranges.count - 1) {
            self.location = NSNumber.init(value: self.ranges[page.intValue].location)
        }
        DZMKeyedArchiver.archiver(folderName: "\(self.novel_id)", fileName: "\(self.novel_id)", object: self)
    }
    
    
    
    
}




class RDReadPageModel {
    /// 当前页内容
    var content:NSAttributedString!
    
    /// 当前页范围
    var range:NSRange!
    
    /// 当前页序号
    var page:Int!
    
    var contentSize : CGSize!
    
    init() {
        
    }
    
}














