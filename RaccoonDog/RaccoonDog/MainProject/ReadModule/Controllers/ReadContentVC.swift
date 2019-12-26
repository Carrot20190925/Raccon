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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initReadView()
        // Do any additional setup after loading the view.
    }
    
    /// 初始化阅读视图
    func initReadView() {
        
        // 是否为书籍首页
        
        
        readView = DZMReadView()
        let currentPage = currentReadModel.page
        readView.content = currentReadModel.pageModels[currentPage].content
        view.addSubview(readView)
        readView.frame = DZM_READ_VIEW_RECT
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
