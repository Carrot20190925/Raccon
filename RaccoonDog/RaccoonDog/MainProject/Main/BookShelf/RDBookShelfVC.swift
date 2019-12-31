//
//  RDBookShelfVC.swift
//  RaccoonDog
//
//  Created by carrot on 24/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit
import Kingfisher
private let reuseIdentifier = "Cell"

class RDBookShelfVC: BaseCollectionVC {
    var shelfBooks : [BookShelfModel] = []
    var itemSize : CGSize!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(BookStoreFirstCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let width = (rScreenWidth - 61) / 3.0
        let height = width * 130.0/108.0 + 60
        self.itemSize = CGSize.init(width: width, height: height)
        
        self.initRefresh()

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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.shelfBooks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookStoreFirstCell
        let item = self.shelfBooks[indexPath.row]
        if let face = item.face{
            cell.avatarImage.setImage(urlString: face)
        }else{
            cell.avatarImage.image = UIImage.init(named: "")
        }
        
        cell.bookNameLabel.text = item.title
        cell.bookAuthorLabel.text = item.author
        return cell
    }
    

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = self.shelfBooks[indexPath.row]
        let novelListVC = NovelListVC.init()
        novelListVC.bookItem = item
        self.navigationController?.pushViewController(novelListVC, animated: true)
    }



}

//MARK:-  布局
extension RDBookShelfVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.itemSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.init(top: 0, left: 15, bottom: 15, right: 15)
    }


}

//MARK:-  网络请求
extension RDBookShelfVC{
    func initRefresh()  {
        self.collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self] in
            self?.loadData()
        })
    }
    func loadData() {
        RDBookNetManager.bookShelfNetWork(success: {[weak self] (response) in
            guard let view = self?.view else{
                return
            }
            if let model = BaseModel.getModel(data: response){
                if model.code != 200 {
                    view.makeToast(model.message, duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: "\(model.code)", image: nil, style: ToastStyle.init(), completion: nil)
                }else{
                    self?.shelfBooks.removeAll()
                    if let datas =  model.data as? Array<Any>{
                        for item in datas {
                            guard let model = BookShelfModel.getModel(data: item) else {
                                continue
                            }
                            self?.shelfBooks.append(model)
                        }
                    }
                    self?.collectionView.reloadData()
                }
            }
            self?.collectionView.mj_header?.endRefreshing()
            MyLog(response)
        }) {[weak self] (error) in
            self?.collectionView.mj_header?.endRefreshing()
            MyLog(error)
        }
    }
}
