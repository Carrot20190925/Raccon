//
//  ReadConfigModel.swift
//  RaccoonDog
//
//  Created by carrot on 25/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation






let RD_TEXT_COLOR_DEFAULT : UIColor = TXTheme.rgbColor(46, 46, 46)
let RD_TEXT_COLOR_FIRST : UIColor = TXTheme.rgbColor(46, 46, 46)
let RD_TEXT_COLOR_SECOND : UIColor = TXTheme.rgbColor(46, 46, 46)
let RD_TEXT_COLOR_THIRD : UIColor = TXTheme.rgbColor(46, 46, 46)
let RD_TEXT_COLOR_FOURTH : UIColor = TXTheme.rgbColor(46, 46, 46)
let RD_TEXT_COLOR_FIVETH : UIColor = TXTheme.rgbColor(46, 46, 46)



///间距列表

let RD_SPACE_5 : CGFloat = 5
let RD_SPACE_6 : CGFloat = 6
let RD_SPACE_7 : CGFloat = 7
let RD_SPACE_8 : CGFloat = 8
let RD_SPACE_9 : CGFloat = 9
let RD_SPACE_10 : CGFloat = 10
let RD_SPACE_11 : CGFloat = 11
let RD_SPACE_12 : CGFloat = 12
let RD_SPACE_13 : CGFloat = 13
let RD_SPACE_14 : CGFloat = 14
let RD_SPACE_15 : CGFloat = 15
let RD_SPACE_16 : CGFloat = 16
let RD_SPACE_17 : CGFloat = 17
let RD_SPACE_18 : CGFloat = 18
let RD_SPACE_19 : CGFloat = 19
let RD_SPACE_20 : CGFloat = 20
let RD_SPACE_21 : CGFloat = 21
let RD_SPACE_22 : CGFloat = 22
let RD_SPACE_23 : CGFloat = 23
let RD_SPACE_24 : CGFloat = 24


//[TXTheme.rgbColor(255, 255, 255),
//                     TXTheme.rgbColor(236, 224, 204),
//                     TXTheme.rgbColor(212, 237, 208),
//                     TXTheme.rgbColor(243, 226, 175),
//                     TXTheme.rgbColor(211, 232, 240)
//                   ]



///
let RD_READ_FONT_SIZE_SPACE_TITLE : CGFloat = 8


/// 书籍来源类型
enum RDBookSourceType:Int {
    /// 网络小说
    case network
    /// 本地小说
    case local
}

/// 阅读翻页类型
enum RDEffectType:Int {
    /// 仿真
    case simulation = 0
    /// 平移
    case translation
    /// 滚动
    case scroll
    /// 无效果
    case no
}

/// 阅读字体类型
enum RDFontType:Int {
    /// 系统
    case system = 0
    /// 黑体
    case one
    /// 楷体
    case two
    /// 宋体
    case three
}

/// 阅读内容间距类型
enum RDSpacingType:Int {
    /// 小间距
    case small = 0
    /// 适中间距
    case middle
    /// 大间距
    case big


}

/// 阅读进度类型
enum RDProgressType:Int {
    /// 总进度
    case total
    /// 分页进度
    case page
}

/// 分页内容是以什么开头
enum RDPageHeadType:Int {
    /// 章节名
    case chapterName
    /// 段落
    case paragraph
    /// 行内容
    case line
}


/// 背景类型
enum RDBackgroudType:Int {
    case zero = 0
    ///
    case one
    ///
    case two
    ///
    case three
    
    case four

}

let RD_ReadConfigModelKey = "RD_ReadConfigModel_User"
private var configure:ReadConfigModel?

class ReadConfigModel{


    var contentSever = RD_Content_Server
    var imageSever = RD_Image_Server
    
    //翻页类型
    var effectType : RDEffectType = .simulation
    //背景色
    var backgroudType : RDBackgroudType = .zero
    //字体大小
    var fontSize = 15
    //字体类型
    var fontType : RDFontType = .system
    //间距类型
    var spacingType : RDSpacingType = .middle
    //是否是白天
    var isDay = true
    ///段间距
    var paragraphSpacing:CGFloat  {
        switch spacingType {
        case .big:
            return RD_SPACE_20
        case .middle:
            return RD_SPACE_15
        case .small:
            return RD_SPACE_10
        }
    }
        
        
        
    ///行间距

    var lineSpacing:CGFloat {
        switch spacingType {
        case .big:
            return RD_SPACE_10
        case .middle:
            return RD_SPACE_7
        case .small:
            return RD_SPACE_5
        }
    }
        
    
    ///字体颜色
    var textColor : UIColor {
        switch self.backgroudType {
        case .zero:
            return TXTheme.rgbColor(171, 171, 171)
        case .one:
            return TXTheme.rgbColor(169, 166, 160)
        case .two:
            return TXTheme.rgbColor(157, 161, 156)
        case .three:
            return TXTheme.rgbColor(168, 165, 155)
        case .four:
            return TXTheme.rgbColor(163, 170, 172)
        }
    }
    
    ///
    var statusColor : UIColor {
        return TXTheme.rgbColor(145, 145, 145)
    }
    
    
    /// 阅读字体
    func font(isTitle:Bool = false) ->UIFont {
        
        let size = RD_SIZE(CGFloat.init(fontSize) + (isTitle ? RD_READ_FONT_SIZE_SPACE_TITLE : 0.0))
                            
        let fontType = self.fontType
        
        if fontType == .one { // 黑体
            
            return UIFont(name: "EuphemiaUCAS-Italic", size: size)!
            
        }else if fontType == .two { // 楷体
            
            return UIFont(name: "AmericanTypewriter-Light", size: size)!
            
        }else if fontType == .three { // 宋体
            
            return UIFont(name: "Papyrus", size: size)!
            
        }else{ // 系统
            
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    
    

    
    
    
      /// 获取对象
    @discardableResult
    class func shared() ->ReadConfigModel {
      
        if configure == nil { configure = ReadConfigModel(UserDefaults.standard.object(forKey: RD_ReadConfigModelKey)) }
      
      return configure!
    }

    init(_ dict:Any? = nil) {
        if dict != nil,let param = dict as? Dictionary<String,Any> {
            if let turnPageType = param["turnPageType"] as? Int{
                self.effectType = RDEffectType.init(rawValue: turnPageType) ?? .simulation
            }
            if let backgroudType = param["backgroudType"] as? Int{
                self.backgroudType = RDBackgroudType.init(rawValue: backgroudType) ?? .zero
            }
            if let fontType = param["fontType"] as? Int{
                self.fontType = RDFontType.init(rawValue: fontType) ?? .system
            }
            if let spacingType = param["spacingType"] as? Int{
                self.spacingType = RDSpacingType.init(rawValue: spacingType) ?? .middle
            }
            if let fontSize = param["fontSize"] as? Int{
                self.fontSize = fontSize
            }
            
            if let contentSever = param["contentSever"] as? String{
                self.contentSever = contentSever
            }
            if let imageSever = param["imageSever"] as? String{
                self.imageSever = imageSever
            }
            if let isDay = param["isDay"] as? Bool{
                self.isDay = isDay
            }
            
        }
        
        //MARK:-  请求配置域名
        RDBookNetManager.getConfigNetwork(success: { [weak self](response) in
            if let model = BaseModel.getModel(data: response),model.code == 200,let data = model.data as? Dictionary<String,Any>{
                if let contentSever = data["Chapter"] as? String{
                    self?.contentSever = contentSever
                }
                if let imageSever = data["Img"] as? String {
                    self?.imageSever = imageSever
                }
                self?.save()
            }
        }) { (error) in
            
        }
    }
    
    
    /// 字体属性
    /// isPaging: 为YES的时候只需要返回跟分页相关的属性即可 (原因:包含UIColor,小数点相关的...不可返回,因为无法进行比较)
    func attributes(isTitle:Bool, isPageing:Bool = false) ->[NSAttributedString.Key:Any] {
        
        // 段落配置
        let paragraphStyle = NSMutableParagraphStyle()
        
        // 当前行间距(lineSpacing)的倍数(可根据字体大小变化修改倍数)
        paragraphStyle.lineHeightMultiple = 1.0
        
        if isTitle {
            
            // 行间距
            paragraphStyle.lineSpacing = 0
            
            // 段间距
            paragraphStyle.paragraphSpacing = 10
            
            // 对其
            paragraphStyle.alignment = .center
            
        }else{
            
            // 行间距
            paragraphStyle.lineSpacing = lineSpacing
            
            // 段间距
            paragraphStyle.paragraphSpacing = paragraphSpacing
            
            // 对其
            paragraphStyle.alignment = .justified
        }
        
        if isPageing {
            
            return [.font: font(isTitle: isTitle), .paragraphStyle: paragraphStyle]
            
        }else{
            
            return [.foregroundColor: textColor, .font: font(isTitle: isTitle), .paragraphStyle: paragraphStyle]
        }
    }
    
    
    //[TXTheme.rgbColor(255, 255, 255),
    //                     TXTheme.rgbColor(236, 224, 204),
    //                     TXTheme.rgbColor(212, 237, 208),
    //                     TXTheme.rgbColor(243, 226, 175),
    //                     TXTheme.rgbColor(211, 232, 240)
    //                   ]
    
    func backgroudColor() -> UIColor {
        switch self.backgroudType {
        case .zero:
            return TXTheme.rgbColor(255, 255, 255)
        case .one:
            return TXTheme.rgbColor(236, 224, 204)
        case .two:
            return TXTheme.rgbColor(212, 237, 208)
        case .three:
            return TXTheme.rgbColor(243, 226, 175)
        case .four:
            return TXTheme.rgbColor(211, 232, 240)
        }
    }
    
    func fontColor() -> UIColor {
        switch self.backgroudType {
        case .zero:
            return TXTheme.rgbColor(171, 171, 171)
        case .one:
            return TXTheme.rgbColor(169, 166, 160)
        case .two:
            return TXTheme.rgbColor(157, 161, 156)
        case .three:
            return TXTheme.rgbColor(168, 165, 155)
        case .four:
            return TXTheme.rgbColor(163, 170, 172)
        }
    }
    
    func menuBackgroudColor() -> UIColor {
        return TXTheme.rgbColor(55, 55, 55, 0.8)
    }

    func save() {
        let param = ["turnPageType":effectType.rawValue,
                    "backgroudType":backgroudType.rawValue,
                    "fontSize":fontSize,
                    "fontType":fontType.rawValue,
                    "spacingType":spacingType.rawValue,
                    "contentSever":contentSever,
                    "imageSever":imageSever,
                    "isDay":isDay
            ] as [String : Any]
        UserDefaults.standard.set(param, forKey: RD_ReadConfigModelKey)
        UserDefaults.standard.synchronize()
    }
    
    
}
