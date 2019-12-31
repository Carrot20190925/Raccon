//
//  BookStoreListVC.swift
//  RaccoonDog
//
//  Created by carrot on 24/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BookStoreListVC: BaseCollectionVC,BannerViewDelegate {

    
    var firstSectionSize : CGSize!
    var secondSectionSize : CGSize!
//    var books  = ["aa"]
    
    var models : [BookListModel] = []
    var bannerList : [BannerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (rScreenWidth - 55) / 3.0
        let height = width * 130.0/108.0
        self.firstSectionSize = CGSize.init(width: width, height: height + 55)
        
        self.secondSectionSize = CGSize.init(width: rScreenWidth, height: height + 10 + 16 + 10)
        
        
//        self.collectionView.backgroundColor = UIColor.green
        // Register cell classes
        
        
        self.collectionView.register(BookStoreHeadView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BookStoreHeadView")

        self.collectionView!.register(BookStoreSecondCell.self, forCellWithReuseIdentifier: "BookStoreSecondCell")

        self.collectionView!.register(BookStoreFirstCell.self, forCellWithReuseIdentifier: "BookStoreFirstCell")
        self.collectionView.register(BannerReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BannerReusableView")

        self.loadData()
        // Do any additional setup after loading the view.
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
        return self.models.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models[section].novelList?.data?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = self.models[indexPath.section]
        if model.page_type == "list" {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookStoreSecondCell", for: indexPath) as! BookStoreSecondCell
            if  let item = model.novelList?.data?[indexPath.row]{
                cell.bookNameLabel.text = item.title
                cell.bookAuthorLabel.text = "\(item.source_category ?? "") | \(item.author ?? "")"
                cell.bookDescLabel.text = item.description
                cell.bookScoreLabel.text = String.init(format: "%.1lf分", item.score ?? 10)
                if let imageUrl = item.face {
                    cell.avatarImage.setImage(urlString: imageUrl)
                }else{
                    cell.avatarImage.image = UIImage.init(named: "")
                }
            }
            return cell
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookStoreFirstCell", for: indexPath) as! BookStoreFirstCell
        
            if let item = model.novelList?.data?[indexPath.row] {
                cell.bookAuthorLabel.text = item.author
                cell.bookNameLabel.text = item.title

                if let imageUrl = item.face {
                    cell.avatarImage.setImage(urlString: imageUrl)
                }else{
                    cell.avatarImage.image = UIImage.init(named: "")
                }
            }
            return cell
        }
    
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
               return self.bannerHeadView(collectionView, indexPath: indexPath,kind: kind)
            default:
                return self.normalHeadView(collectionView, indexPath: indexPath, kind: kind)
                
            }

        }else{
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BannerReusableView", for: indexPath)
            return headView
            
        }

    }
    
    
    
    //MARK:-  banner headview
    private func bannerHeadView(_ collectionView: UICollectionView,indexPath: IndexPath,kind: String) -> BannerReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BannerReusableView", for: indexPath) as! BannerReusableView
        headView.bannerView.delegate = self;
        headView.bannerView.resetAction()
        headView.selectedCategory = { type in
            switch type {
            case 0://分类
                let categoryVC = CategroyVC.init()
                categoryVC.title = RD_localized("分类", "")
                self.navigationController?.pushViewController(categoryVC, animated: true)
                break
            case 1://榜单
                break;
            case 2://完结
                break;
            case 3://出版
                break
                
            default:
                break
            }
        }
        return headView
    }
    
    //MARK:- 普通HeadView
    private func normalHeadView(_ collectionView: UICollectionView,indexPath: IndexPath,kind: String) -> BookStoreHeadView {
        let model = self.models[indexPath.section]
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BookStoreHeadView", for: indexPath) as! BookStoreHeadView

        headView.titleLabel.text = model.mt_title
        headView.titleLabel.sizeToFit()
        headView.actionBtn.isHidden = model.page_type != "autochange"
        
        return headView
    }
    
    

    // MARK: UICollectionViewDelegate

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.models[indexPath.section].novelList?.data?[indexPath.row]
        guard let book_uuid = model?.book_uuid else{
            self.view.makeToast(RD_localized("没有书籍id", ""))
            return
        }
        let detailVC = BookDetailVC.init(collectionViewLayout: UICollectionViewFlowLayout.init())
        detailVC.book_uuid = book_uuid
        detailVC.title = model?.title
        self.navigationController?.pushViewController(detailVC, animated: true)
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
    
    //MARK:-  BannerViewDelegate
    func modelsCount() -> Int {
        return self.bannerList.count
    }
    
    func currentIndex(index: Int, imageView: BannerImageView) {
        let model = self.bannerList[index]
        if let url = model.poster_img {
            imageView.setImage(urlString: url)
        }else{
            imageView.image = UIImage.init(named: "")
        }
        imageView.label.text = model.poster_title
   
    }
    
    func clickImageAction(index: Int) {
        MyLog("\(index)")
    }
    

}


extension BookStoreListVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            let width = rScreenWidth  - 16 * 2;
            let height = width * 150.0/343.0 + 115.0
            return CGSize.init(width: rScreenWidth, height: height)
        }
        return CGSize.init(width: rScreenWidth, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let model = self.models[indexPath.section]
        if model.page_type == "list" {
            return self.secondSectionSize

        }else{
            return self.firstSectionSize

        }

//        switch indexPath.section {
//        case 0:
//            return CGSize.zero
//        case 1:
//            return self.firstSectionSize
//        case 2:
//            return self.secondSectionSize
//        default:
//            return CGSize.zero
//        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        let model = self.models[section]
        if model.page_type != "list" {
            return UIEdgeInsets.init(top: 15, left: 16, bottom: 0, right: 16)

        }
        return UIEdgeInsets.zero
    }
    
    func loadData()  {
        
        self.view.makeToastActivity(.center)
        
        
        
        
        RDBookNetManager.bookStoreListNetWork(success: {[weak self] (response) in
            if let model = BaseModel.getModel(data: response),model.code == 200,let datas = model.data as? Array<NSDictionary> {
                self?.models.removeAll()
                let model = BookListModel.init(id: 0)
                model.mt_title = "banner"
                self?.models.append(model)
                for item in datas {
                    if let model = BookListModel.getModel(data: item){
                        self?.models.append(model)
                    }
                }
            }
            self?.collectionView.mj_header?.endRefreshing()
            self?.view.hideToastActivity()
            self?.collectionView.reloadData()
            
        }) {[weak self] (error) in
            self?.collectionView.mj_header?.endRefreshing()
            self?.view.hideToastActivity()
            MyLog(error)
        }
        
        
        
        
        RDBookNetManager.bookBannerNetwork(1, success: {[weak self] (response) in
            if let model = BaseModel.getModel(data: response),model.code == 200,let datas = model.data as? Array<NSDictionary> {
                self?.bannerList.removeAll()
                for item in datas {
                    if let model = BannerModel.getModel(data: item) {
                        self?.bannerList.append(model)
                    }
                }
                self?.collectionView.reloadData()
            }
            MyLog(response)
        }) { (error) in
            MyLog(error)
        }
    }
}
