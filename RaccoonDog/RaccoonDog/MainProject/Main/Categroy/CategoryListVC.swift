//
//  BookStoreListVC.swift
//  RaccoonDog
//
//  Created by carrot on 24/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

enum CategoryListType {
    case Defalut
    case one
}
class CategoryListVC: BaseCollectionVC {
    var firstSectionSize : CGSize!
//    var secondSectionSize : CGSize!
//    var books
    var type  = CategoryListType.Defalut
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (rScreenWidth - 66) / 2.0
        let height = width * 87.0/154.0
        self.firstSectionSize = CGSize.init(width: width, height: height)
        
//        self.secondSectionSize = CGSize.init(width: rScreenWidth - 32, height: height + 10 + 16 + 10)
//        self.collectionView.backgroundColor = UIColor.green
        // Register cell classes
        
        self.collectionView.register(UINib.init(nibName: "CategoryCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CategoryCell")
//        self.collectionView!.register(BookStoreSecondCell.self, forCellWithReuseIdentifier: "BookStoreSecondCell")

//        self.collectionView!.register(BookStoreFirstCell.self, forCellWithReuseIdentifier: "BookStoreFirstCell")
//        self.collectionView.register(BannerReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BannerReusableView")

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
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        return cell
    
        // Configure the cell
    
    }
    
//
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BannerReusableView", for: indexPath) as! BannerReusableView
//            headView.selectedCategory = { type in
//                switch type {
//                case 0://分类
//                    break
//                case 1://榜单
//                    break;
//                case 2://完结
//                    break;
//                case 3://出版
//                    break
//
//                default:
//                    break
//                }
//            }
//            return headView
//        }else{
//            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BannerReusableView", for: indexPath)
//            return headView
//
//        }
//
//    }
    
    
    

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


extension CategoryListVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.firstSectionSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.init(top: 15, left: 23, bottom: 0, right: 23)
    }
    
    func loadData()  {
        
    }
}
