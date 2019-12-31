//
//  BookStoreVC.swift
//  RaccoonDog
//
//  Created by carrot on 24/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit
class BookStoreVC: BaseController {
    
    
    var models : [BookStoreModel] = []
    var seletedBtn : UIButton?
    var indicator = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 2))
    var titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: rScreenWidth, height: NavgationBarHeight))
    var titleScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y:StatusBarHeight , width: rScreenWidth - 70, height: NavgationBarHeight - StatusBarHeight))
    var searchButton = UIButton.init(frame: CGRect.init(x: rScreenWidth - 60, y: StatusBarHeight, width: 60, height: 0))
    var titleBtns : [UIButton] = []
    
        
    var bodyView = UIScrollView.init(frame: CGRect.init(x: 0, y: NavgationBarHeight, width: rScreenWidth, height: rScreenHeight - NavgationBarHeight - TabBarHeight))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.titleView)
        self.titleView.addSubview(self.titleScrollView)
        self.titleView.addSubview(searchButton)
        self.view.addSubview(self.bodyView)
        self.bodyView.isScrollEnabled = false
        self.loadData()
//        self.initSubViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func initTitleView()  {
        
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

//MARK:-  设置

extension BookStoreVC:UIScrollViewDelegate{
    
    /// <#Description#>
    func initSubViews() {
        self.indicator.backgroundColor = TXTheme.themeColor()
    
        if #available(iOS 13.0, *) {
            self.titleScrollView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            self.bodyView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
//            self.bodyView.automaticallyAdjustsScrollIndicatorInsets = false
            // Fallback on earlier versions
        }
        self.bodyView.isPagingEnabled = true
        self.bodyView.bounces = true
        self.titleScrollView.bounces = true
        self.titleScrollView.showsVerticalScrollIndicator = false
        self.titleScrollView.showsHorizontalScrollIndicator = false
        self.searchButton.setTitle("搜索", for: .normal)
        self.searchButton.sizeToFit()
        self.searchButton.setTitleColor(TXTheme.titleColor(), for: .normal)
        self.titleScrollView.delegate = self;
        self.bodyView.delegate = self;
        let titleModels :  [BookStoreModel] = self.models;
        let space : CGFloat = 30
        var x : CGFloat = 20
        self.titleBtns.removeAll()
        for (index,item) in titleModels.enumerated() {
            
            let button = UIButton.init(type: .custom)

            button.setTitle(item.module_title, for: .normal)
            button.sizeToFit()
            button.tag = index
            button.frame = CGRect.init(x: x, y: 0, width: button.mj_w, height: button.mj_h)
            button.addTarget(self, action: #selector(titleAction(sender:)), for: .touchUpInside)
            self.titleBtns.append(button)
            if index == 0 {
                button.isSelected = true
                self.seletedBtn = button
                self.indicator.center = CGPoint.init(x: button.center.x, y: button.mj_h + button.mj_y)
            }
            button.setTitleColor(TXTheme.titleColor(), for: .normal)
            button.setTitleColor(TXTheme.themeColor(), for: .selected)
            self.titleScrollView.addSubview(button)
            x = x + button.mj_w + space
            
            if index > 0 {
                continue
            }
            let listVC = BookStoreListVC.init(collectionViewLayout: UICollectionViewFlowLayout.init())
            listVC.view.frame = CGRect.init(x: CGFloat.init(integerLiteral: index) * rScreenWidth, y: 0, width: rScreenWidth, height: self.bodyView.mj_h)

            self.addChild(listVC)
            
            self.bodyView.addSubview(listVC.view)
        }
        self.titleScrollView.addSubview(self.indicator)
        self.titleScrollView.contentSize = CGSize.init(width: x, height: NavgationBarHeight - StatusBarHeight)
        self.bodyView.contentSize = CGSize.init(width: rScreenWidth * CGFloat.init(integerLiteral: titleModels.count), height: self.bodyView.mj_h)
        
    }
    
    
    
    @objc func titleAction(sender:UIButton){
    
        
//        self.setupScrollView(sender: sender)
    }
    
    
    //MARK:-  处理滑动事件暂时不用
    private func setupScrollView(sender:UIButton){
        if self.seletedBtn == sender {
            return
        }
        
        let x = sender.center.x
        let titleContentViewW = self.titleScrollView.contentSize.width
        let halfW = self.titleScrollView.mj_w * 0.5
        
        if x > halfW,(x + halfW) < titleContentViewW  {
           let  offsetX = x - halfW
           self.titleScrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)

        }else if x < halfW {
           self.titleScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }

        self.seletedBtn?.isSelected = false
        sender.isSelected = true
        self.seletedBtn = sender
        self.indicator.center = CGPoint.init(x: sender.center.x, y: sender.mj_y + sender.mj_h)
        let tag = sender.tag
        self.bodyView.setContentOffset(CGPoint.init(x: CGFloat.init(integerLiteral: tag) * self.bodyView.mj_w, y: 0), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.bodyView {
            let totalOffsetX = scrollView.contentOffset.x;
            let currentX = CGFloat.init(integerLiteral: (self.seletedBtn?.tag ?? 0)) * scrollView.mj_w
            let offsetX = totalOffsetX - currentX
            
            let indicatorOffsetX =  offsetX * self.titleScrollView.contentSize.width / self.bodyView.contentSize.width
            let centerX = (self.seletedBtn?.center.x ?? 20.0) + indicatorOffsetX
            let centerY = (self.seletedBtn?.mj_y ?? 0)  + (self.seletedBtn?.mj_h ?? 0)
            self.indicator.center = CGPoint.init(x: centerX, y: centerY)

        }else{
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        MyLog("end")
        if scrollView == self.bodyView {
            let currentTag = Int.init((scrollView.contentOffset.x + scrollView.mj_w * 0.5) / scrollView.mj_w);
            if currentTag < (self.titleBtns.count) ,let btn = self.titleBtns[currentTag] as? UIButton {
                self.titleAction(sender: btn)
            }
            
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == self.bodyView {
            
        }
    }
    
    
    
    
}

extension BookStoreVC{
    private func loadData(){
        self.view.makeToastActivity(ToastPosition.center)
        let firstModel = BookStoreModel.init(id: 100, title:  RD_localized("精选", ""))
        self.models.append(firstModel)
        RDBookNetManager.bookStoreNetWork(success: {[weak self] (response) in
            self?.view.hideToastActivity()
            if  let model = BaseModel.getModel(data: response),model.code == 200,let datas = model.data as? Array<Dictionary<String,Any>>{
                
                for item in datas {
                    if let model = BookStoreModel.getModel(data: item){
                        self?.models.append(model)
                    }
                }
            }
            self?.initSubViews()
            MyLog(response)
        }) { [weak self](error) in
            self?.view.hideToastActivity()
            MyLog(error)
            self?.initSubViews()
        }
        
        
    }
}
