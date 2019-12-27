//
//  ReadVC.swift
//  RaccoonDog
//
//  Created by carrot on 25/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class ReadVC: BaseController {
    let topView = ReadTopView.init(frame: CGRect.init(x: 0, y: -NavgationBarHeight, width: rScreenWidth, height: NavgationBarHeight))
    var showMenu = false
    /// 用于区分正反面的值(勿动)
    var tempNumber:Int = 1
    var contentView : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: rScreenWidth, height: rScreenHeight))
    var pageViewController : UIPageViewController!
    var readModel : ReadModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMenu()
        self.contentView.addSubview(self.topView)
        self.view.addSubview(contentView)
        self.updateReadController()
        self.addSingleTap()
        
        // Do any additional setup after loading the view.
    }
    
    
    

    
    
    
    
    func updateReadController()  {
        switch ReadConfigModel.shared().effectType {
        case .simulation:
            self.setupPageController()
        case .translation:
            break
        case .scroll:
            break;
        default:
            break;
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.readModel.currentReadModel.save()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

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



extension ReadVC:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    // MARK: -- UIPageViewControllerDataSource
    ///获取上一页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 翻页累计
        tempNumber -= 1

        // 获取当前页阅读记录
        var recordModel:ParserReadModel? = (viewController as? ReadContentVC)?.currentReadModel

        // 如果没有则从背面页面获取
        if recordModel == nil {
            return nil
            
//            recordModel = (viewController as? DZMReadViewBGController)?.recordModel
        }

        if abs(tempNumber) % 2 == 0 { // 背面

            recordModel = GetAboveReadRecordModel(recordModel: recordModel)

            return getReadContentVC(currentReadModel: recordModel)

        }else{ // 内容

            return getReadContentVC(currentReadModel: recordModel)
        }
//        return ReadContentVC.init()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        tempNumber += 1
        
        // 获取当前页阅读记录
        var recordModel:ParserReadModel? = (viewController as? ReadContentVC)?.currentReadModel
        
        // 如果没有则从背面页面获取
        if recordModel == nil {
            return nil
//            recordModel = (viewController as? DZMReadViewBGController)?.recordModel
        }
        
        if abs(tempNumber) % 2 == 0 { // 背面

            return getReadContentVC(currentReadModel: recordModel)
            
        }else{ // 内容
            
            recordModel = GetBelowReadRecordModel(recordModel: recordModel)
            return getReadContentVC(currentReadModel: recordModel)
        }

    }
    
    /// 切换结果
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // 记录
        let  currentDisplayController = pageViewController.viewControllers?.first as? ReadContentVC
        
        readModel.currentReadModel =  currentDisplayController?.currentReadModel
//        readModel.currentReadModel.save()
        // 更新阅读记录
//        updateReadRecord(controller: currentDisplayController)
    }
    
    /// 准备切换
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
//        readMenu.showMenu(isShow: false)
    }
    func updateReadRecord(controller : ReadContentVC ) {
        
    }

    
    func setupPageController()  {
        guard let displayController = getReadContentVC(currentReadModel: readModel.currentReadModel) else{
            return
        }
        // 创建
        let options = [UIPageViewController.OptionsKey.spineLocation : NSNumber(value: UIPageViewController.SpineLocation.min.rawValue)]
        
        pageViewController = UIPageViewController(transitionStyle: .pageCurl,navigationOrientation: .horizontal,options: options)
        
        pageViewController.delegate = self
        
        pageViewController.dataSource = self
        
        // 翻页背部带文字效果
        pageViewController.isDoubleSided = true
        
        contentView.insertSubview(pageViewController.view, at: 0)
        
        pageViewController.view.backgroundColor = UIColor.clear
        
        pageViewController.view.frame = contentView.bounds
        pageViewController.setViewControllers([displayController], direction: .forward, animated: false, completion: nil)

    }
}



extension ReadVC{
    func getReadContentVC(currentReadModel : ParserReadModel!) -> ReadContentVC? {
        if currentReadModel != nil{
            if  currentReadModel.pageModels.count == 0{
                return nil
            }
            let controller = ReadContentVC.init()
            controller.currentReadModel = currentReadModel
            return controller
        }
        return nil
    }
    
    
        /// 获取当前记录上一页阅读记录
    func GetAboveReadRecordModel(recordModel:ParserReadModel!) ->ParserReadModel? {
        
        // 阅读记录为空
        if recordModel.pageModels.count == 0 { return nil }
        
        let recordModel = recordModel.copy() as! ParserReadModel
        // 第一章 第一页
        if recordModel.isFirstChapter && recordModel.isFirstPage {
            
            DZMLog("已经是第一页了")
            
            return nil
        }
        
        // 第一页
        if recordModel.isFirstPage {
            self.readModel.currentReadModel = recordModel.previousModel
            recordModel.previousModel?.page = NSNumber.init(value: (recordModel.previousModel?.pageModels.count ?? 1) - 1)
            return recordModel.previousModel
            
        }else{ recordModel.previousPage() }
        
        // ----- 搜索网络小说 -----
        
        // 预加载上一章(可选)(一般上一章就要他自己拉一下加载吧,看需求而定,上下滚动模式的就会提前加载好上下章节)
        
        return recordModel
    }
    
    
    /// 获取当前记录下一页阅读记录
    func GetBelowReadRecordModel(recordModel:ParserReadModel!) ->ParserReadModel?  {
        
        // 阅读记录为空

        // 最后一章 最后一页
        if recordModel.isLastChater && recordModel.isLastPage {
            
            DZMLog("已经是最后一页了")
            
            return nil
        }
        
        let recordModel = recordModel.copy() as! ParserReadModel
        
        // 最后一页
        if recordModel.isLastPage {
            self.readModel.currentReadModel = recordModel.nextModel
            return recordModel.nextModel
            
        }else{ recordModel.nextPage() }
        
        return recordModel
    }
}

extension ReadVC:UIGestureRecognizerDelegate{
    //MARK:-  增加手势
    func addSingleTap() {
                // 单击手势
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(touchSingleTap))
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        self.contentView.addGestureRecognizer(singleTap)
    }
    
    
    @objc func touchSingleTap(){
        self.showMenu = !self.showMenu
        if self.showMenu {
            UIView.animate(withDuration: 0.25) {
                self.topView.mj_y = 0
            }
        }else{
            UIView.animate(withDuration: 0.25) {
                self.topView.mj_y = -self.topView.mj_h
            }
        }
        
    }
    
}


//MARK:-  菜单协议
extension ReadVC : ReadMenuProtocol{
    func initMenu()  {
        self.topView.delegate = self;
    }
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
