//
//  ReadVC.swift
//  RaccoonDog
//
//  Created by carrot on 25/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class ReadVC: BaseController {
    
    weak var novelListVC : NovelListVC?
    let topView = ReadTopView.init(frame: CGRect.init(x: 0, y: -NavgationBarHeight, width: rScreenWidth, height: NavgationBarHeight))
    
    let bottomView = ReadBottomView.init(frame: CGRect.init(x: 0, y: rScreenHeight, width: rScreenWidth, height: TabBarHeight))
    ///菜单是否展示
    var showMenu = false
    ///目录是否展示
    var showNovelList = false
    /// 用于区分正反面的值(勿动)
    var tempNumber:Int = 1
    var contentView : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: rScreenWidth, height: rScreenHeight))
    var pageViewController : UIPageViewController!
    var readModel : ReadModel!
    
    
    var menuView = UIView.init()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.clipsToBounds = true
        self.view.addSubview(contentView)
        self.initMenu()


//        self.view.addSubview(self.topView)
//        self.view.addSubview(self.bottomView)
        self.updateReadController()
        self.addSingleTap()
        
        // Do any additional setup after loading the view.
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationResignAction), name: NSNotification.Name.init(RD_Resign_Active_Notification), object: nil)
    }
    
    @objc
    func applicationResignAction() {
        self.readModel.currentReadModel.save()
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
        self.showMenu = false
        self.showNovelList = false
        self.setMenu()
//        readMenu.showMenu(isShow: false)
    }
    func updateReadRecord(controller : ReadContentVC ) {
        
    }

    
    func setupPageController()  {
        guard let displayController = getReadContentVC(currentReadModel: readModel.currentReadModel) else{
            return
        }
        
        if let pageControl = pageViewController {
            pageViewController.setViewControllers([displayController], direction: .forward, animated: false, completion: nil)

        }else{
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
        self.setMenu()
    }
    
    //MARK:-  菜单设置
    func setMenu() {
        
        if self.showMenu || self.showNovelList {
//            self.menuView.isHidden = false
            self.view.addSubview(self.menuView)
        }
        if self.showMenu {
            self.showNovelList = false
            UIView.animate(withDuration: 0.3) {
                self.topView.mj_y = 0
                self.bottomView.mj_y = rScreenHeight - self.bottomView.mj_h
            }
            
        }else{
            
            if self.topView.mj_y == 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.topView.mj_y = -self.topView.mj_h
                    self.bottomView.mj_y = rScreenHeight
                }) { (finish) in
                    if finish{
                        if !self.showNovelList{
                            self.menuView.removeFromSuperview()
                        }
                    }

                }

            }

        }
        if let novelVC = self.novelListVC,!self.showNovelList  {
            if novelVC.view.mj_x != 0 {
                return
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                novelVC.view.mj_x = -novelVC.view.mj_w

            }) { (finish) in
                if finish{
                    if !self.showMenu{
                        self.menuView.removeFromSuperview()
//                        self.menuView.isHidden = true
                    }
                }

            }
        }

    }

    
}


//MARK:-  菜单协议
extension ReadVC : ReadMenuProtocol{
    func initMenu()  {
        
        let tap =  UITapGestureRecognizer.init(target: self, action: #selector(tapMenuAction))
        tap.numberOfTapsRequired = 1
        self.menuView.frame = self.view.bounds
//        self.menuView.addGestureRecognizer(tap)
//        self.menuView.isHidden = true
        self.menuView.backgroundColor = TXTheme.rgbColor(0, 0, 0, 0.6)
        self.topView.delegate = self;
        self.bottomView.delegate = self;
        
//        self.view.addSubview(self.menuView)
        let actionView = UIView.init(frame: self.menuView.bounds)
        actionView.addGestureRecognizer(tap)
        self.menuView.addSubview(actionView)
        self.menuView.addSubview(self.topView)
        self.menuView.addSubview(self.bottomView)
    }
    
    
    @objc
    func tapMenuAction()  {
        self.showMenu = false
        self.showNovelList = false
        self.setMenu()
    }
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:-  改变日夜模式
    func changeDayNight() {
        
    }
    //MARK:-  展示列表
    func showList() {
        self.showMenu = false
        self.showNovelList = !self.showNovelList
        self.setMenu()
        if !self.showNovelList{
            return
        }
        if let novelVC = self.novelListVC {
            novelVC.tableView.reloadData()
            UIView.animate(withDuration: 0.25) {
                novelVC.view.mj_x = 0
            }
        }else{
            let novelistVC = NovelListVC.init()
            novelistVC.seletedChapter = {[weak self] in
                self?.showNovelList = false
                self?.setMenu()
                self?.updateReadController()
            }
            novelistVC.readModel = self.readModel
            let width = rScreenWidth * 0.7
            let height = rScreenHeight
            novelistVC.view.frame = CGRect.init(x: -width, y: 0, width: width, height: height)
//            novelistVC.view.backgroundColor = TXTheme.rgbColor(0, 0, 0, 1)
//            novelistVC.view.frame = CGRect.init(x:0, y: 0, width: width * 0.8, height: height)
//            novelistVC.tableView.backgroundColor = UIColor.white
            self.addChild(novelistVC)
            self.menuView.addSubview(novelistVC.view)
            self.novelListVC = novelistVC
            UIView.animate(withDuration: 0.25) {
                novelistVC.view.mj_x = 0
            }
        }
    }
    
    
    //MARK:-  展示设置界面
    func showSet() {
        
    }
}
