//
//  BookDetailVC.swift
//  RaccoonDog
//
//  Created by carrot on 30/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BookDetailVC: BaseCollectionVC {

    var book_uuid : String!
    var firstSize : CGSize!
    var secondSize : CGSize!
    var bookModel : BookShelfModel?
    var recommendModel : NovelListModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title =
        self.firstSize = CGSize.init(width: rScreenWidth, height: 50)
        let width = (rScreenWidth - 55) / 3.0
        let height = width * 130.0/108.0
        self.secondSize = CGSize.init(width: width, height: height + 60)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        self.collectionView.register(UINib.init(nibName: "BookDetailListCell", bundle: Bundle.main), forCellWithReuseIdentifier: "BookDetailListCell")
        
        self.collectionView.register(UINib.init(nibName: "BookDetailHeadView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BookDetailHeadView")
        
        self.collectionView.register(BookStoreHeadView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BookStoreHeadView")
        self.collectionView!.register(BookStoreFirstCell.self, forCellWithReuseIdentifier: "BookStoreFirstCell")
        self.loadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return self.recommendModel?.data?.count ?? 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailListCell", for: indexPath) as! BookDetailListCell
            cell.secondBtn.isHidden = true
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookStoreFirstCell", for: indexPath) as! BookStoreFirstCell
            let model = self.recommendModel?.data?[indexPath.row]
            if  let url = model?.face{
                cell.avatarImage.setImage(urlString: url)
            }
            cell.bookAuthorLabel.text = model?.author
            cell.bookNameLabel.text = model?.title

            return cell
        }
    
        // Configure the cell
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                return self.firstSectionHeadView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
            }
            return self.secondSectionHeadView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }else{
            return self.firstSectionHeadView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)

        }
    }
    
    private func firstSectionHeadView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BookDetailHeadView", for: indexPath) as! BookDetailHeadView

        headView.setBookModel(bookModel: bookModel)
        headView.action = { type in
            switch type {
            case 0:
                //MARK:-  加入书架
                self.joinBookSelf()
            case 1:
                //MARK:-  免费阅读
                self.freeToRead()
            case 2:
//MARK:-  加入收藏
                self.joinCollection()
            case 10:
              //MARK:-  展开
                self.showBookDesc()
            default:
                break
            }
            
        }
        
        return headView
    }
    private func secondSectionHeadView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BookStoreHeadView", for: indexPath) as! BookStoreHeadView
        headView.titleLabel.text = RD_localized("看过这本书的人还看过", "")
        headView.titleLabel.sizeToFit()
        headView.actionBtn.isHidden = true
        return headView
    }
    
    
    
    

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let model = self.bookModel else {
                self.loadData()
                self.view.makeToast(RD_localized("加载书籍失败", ""))
                return
            }
            let novelListVC = NovelListVC.init()
            novelListVC.bookItem = model
            self.navigationController?.pushViewController(novelListVC, animated: true)
        }else
        {
            let model = self.recommendModel?.data?[indexPath.row]
            guard let book_uuid = model?.book_uuid else {
                self.view.makeToast(RD_localized("书籍的id有误", ""))
                return
            }
            let detailVC = BookDetailVC.init(collectionViewLayout: UICollectionViewFlowLayout.init())
            detailVC.book_uuid = book_uuid
            detailVC.title = model?.title
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension BookDetailVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 0{
            return self.firstSize
        }
        return self.secondSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if section == 0 {
           return UIEdgeInsets.zero
        }
        return UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if section == 0 {
            let height : CGFloat = 10 + 173 + 10 + 18 + 5 + 14 + 8 + 30 + 19 + 17 + 15 + 9 + 15 + 50 + 5 + 27 + 10;
            return CGSize.init(width: rScreenWidth, height: height)
        }else{
            
            return CGSize.init(width: rScreenWidth, height: 44)
        }
    }
    
    
    
    
    
}


extension BookDetailVC{
    func loadData()  {
        self.view.makeToastActivity(.center)
        RDBookNetManager.bookInfoNetwork(self.book_uuid, success: {[weak self] (response) in
            if let model = BaseModel.getModel(data: response),model.code == 200{
                self?.bookModel = BookShelfModel.getModel(data: model.data)
            }
            self?.collectionView.reloadData()
            self?.view.hideToastActivity()
            MyLog(response)
        }) { [weak self](error) in
            self?.view.hideToastActivity()
            MyLog(error)
        }
        
        RDBookNetManager.bookRecommendNetwork(self.book_uuid, success: {[weak self] (response) in
            if let model = BaseModel.getModel(data: response),model.code == 200{
                self?.recommendModel = NovelListModel.getModel(data: model.data)
                self?.collectionView.reloadData()
            }
        }) { (errro) in
            
        }
    }
    ///加入书架请求
    func joinBookSelf() {
        guard let book_uuid = self.bookModel?.book_uuid else {
            return
        }
        self.view.makeToastActivity(.center)
        RDBookNetManager.addBookSelfNetwork(book_uuid, success: {[weak self] (response) in
            self?.view.hideToastActivity()
            if let model = BaseModel.getModel(data: response), model.code == 200{
                self?.view.makeToast(RD_localized("加入成功", ""))
            }
        }) {[weak self] (error) in
            self?.view.hideToastActivity()
            MyLog(error)
        }
        
    }
    ///免费阅读
    func freeToRead() {
        self.loadReadData()
    }
    
    func loadReadData() {

        
        guard let item = self.bookModel else {
            return
        }
        let  readModel = ReadModel.init(book_uuid: item.book_uuid)
        readModel.bookName = item.title
        readModel.bookAuthor = item.author
        self.view.makeToastActivity(.center)
        if let items = RD_DBManager.getSyncNovelList(novel_id: item.book_uuid),items.count > 0{
            self.setupData(data: items,readModel: readModel)
        }else{
            
            RDBookNetManager.novelChapterNetWork(novel_id: item.book_uuid, success: {[weak self] (response) in
                guard let weakSelf = self else{
                    return
                }
                if let model = BaseModel.getModel(data: response),model.code == 200,let item = model.data as? Dictionary<String,Any>{
                    let datas = item["data"]
                    weakSelf.setupData(data: datas,readModel: readModel)
                    RD_DBManager.share.updateNovelList(data: datas)
                }else{
                    weakSelf.view.hideToastActivity()
                }
                MyLog(response)

            }) {[weak self] (error) in
                self?.view.hideToastActivity()
                MyLog(error)
            }

        }
    }
        
    func setupData(data : Any?,readModel : ReadModel) {
        
        var models : [NovelChapterModel] = []
        if let items = data as? Array<Any> {
            for item in items {
                guard let model = NovelChapterModel.getModel(data: item)  else {
                    continue
                }
                models.append(model)
            }
            readModel.setListModels(models: models)
        }
        
        
        
        if readModel.currentReadModel.pageModels.count > 0 {
            self.view.hideToastActivity()
            let readvc = ReadVC.init()
            readvc.readModel = readModel
            
            self.navigationController?.pushViewController(readvc, animated: true)
        }else{
            if let urlString = readModel.currentReadModel.url{
                RDBookNetManager.novelChapterContentNetWork(url:RD_Content_Server + urlString, success: {[weak self] (response) in
                    self?.view.hideToastActivity()

                    if let content = response as? String{
                        let readvc = ReadVC.init()
                        readvc.readModel = readModel
                        readModel.currentReadModel.setFullText(fullText: content)
                        self?.navigationController?.pushViewController(readvc, animated: true)
                    }
                    MyLog(response)
                    
                }) {[weak self] (error) in
                    self?.view.hideToastActivity()
                    MyLog(error)
                }
            }
        }
    }
    ///加入收藏
    func joinCollection() {
        guard let book_uuid = self.bookModel?.book_uuid else {
            return
        }
        self.view.makeToastActivity(.center)
        RDBookNetManager.addCollectionNetwork(book_uuid, success: {[weak self] (response) in
            self?.view.hideToastActivity()
            if let model = BaseModel.getModel(data: response), model.code == 200{
                self?.view.makeToast(RD_localized("加入成功", ""))
            }
        }) {[weak self] (error) in
            self?.view.hideToastActivity()
            MyLog(error)
        }
        
    }
    ///展开
    func showBookDesc() {
        
    }
    
    
}
