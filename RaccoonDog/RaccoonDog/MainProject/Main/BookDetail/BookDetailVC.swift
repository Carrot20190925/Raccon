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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstSize = CGSize.init(width: rScreenWidth, height: 44)
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
            return 9
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailListCell", for: indexPath) as! BookDetailListCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookStoreFirstCell", for: indexPath) as! BookStoreFirstCell

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
        
        return headView
    }
    private func secondSectionHeadView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BookStoreHeadView", for: indexPath) as! BookStoreHeadView
        return headView
    }
    
    
    
    

    // MARK: UICollectionViewDelegate

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
    }
}
