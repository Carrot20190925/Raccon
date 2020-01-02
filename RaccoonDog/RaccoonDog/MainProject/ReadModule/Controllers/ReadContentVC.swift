//
//  ReadContentVC.swift
//  RaccoonDog
//
//  Created by carrot on 26/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class ReadContentVC: BaseController {

    ///是否是背景view

    var isBack = false
    var currentReadModel : ParserReadModel!
    var readView : DZMReadView!
    let chapterLabel = UILabel.init()
    let bookNameLabel = UILabel.init()
    
    let bottomView = DZMReadViewStatusBottomView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initReadView()
        // Do any additional setup after loading the view.
    }
    
    /// 初始化阅读视图
    func initReadView() {
        self.chapterLabel.textAlignment = .right
        
        let x = DZM_READ_VIEW_RECT.minX
        let y = StatusBarHeight
        let width = rScreenWidth * 0.5 - x
        let height : CGFloat = 15
        self.bookNameLabel.frame = CGRect.init(x: x, y: y, width: width, height: height)
        self.chapterLabel.frame = CGRect.init(x: width + x , y: y, width: width, height: height)
        if currentReadModel.page.intValue != 0 {
            self.chapterLabel.text = currentReadModel.title
        }
        self.chapterLabel.textColor = ReadConfigModel.shared().textColor
        self.bookNameLabel.textColor = ReadConfigModel.shared().textColor
        self.bookNameLabel.font = TXTheme.thirdTitleFont(size: 12)
        self.chapterLabel.font = TXTheme.thirdTitleFont(size: 12)
        
        // 是否为书籍首页
        
        self.view.backgroundColor = ReadConfigModel.shared().backgroudColor()
        readView = DZMReadView()
        let currentPage = currentReadModel.page.intValue
        readView.content = currentReadModel.pageModels[currentPage].content
        
        view.addSubview(readView)
        view.addSubview(self.bookNameLabel)
        view.addSubview(self.chapterLabel)
        view.addSubview(self.bottomView)
        readView.frame = DZM_READ_VIEW_RECT
        // 阅读使用范围
        let readRect = DZM_READ_RECT!
        bottomView.frame = CGRect(x: readRect.minX, y: readRect.maxY - DZM_READ_STATUS_BOTTOM_VIEW_HEIGHT, width: readRect.width, height: DZM_READ_STATUS_BOTTOM_VIEW_HEIGHT)

    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
