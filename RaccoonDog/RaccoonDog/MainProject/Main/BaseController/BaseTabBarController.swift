//
//  BaseTabBarController.swift
//  RaccoonDog
//
//  Created by carrot on 22/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSubVC()
        if #available(iOS 13.0, *){
            let standardAppearance = UITabBarAppearance.init()
            standardAppearance.shadowImage = UIImage.init(color: UIColor.white)
            standardAppearance.backgroundColor = UIColor.white
            standardAppearance.backgroundImage = UIImage.init(color: UIColor.white)
            standardAppearance.stackedItemSpacing = 0.1
            standardAppearance.stackedItemPositioning = .centered
            self.tabBar.standardAppearance = standardAppearance

        }else{
            self.tabBar.shadowImage = UIImage.init();
            self.tabBar.backgroundColor = UIColor.white;
            self.tabBar.backgroundImage = UIImage.init(color: UIColor.white);
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    private func initialSubVC() {
        
        let bookSelfVC = RDBookShelfVC.init(collectionViewLayout: UICollectionViewFlowLayout.init())
        let vcMaps = [
            ["title":"书架","icon":"RD-tab-shelf", "vc":bookSelfVC],
            ["title":"书城","icon":"RD-tab-store", "vc":BookStoreVC.init()],
            ["title":"发现","icon":"RD-tab-discover", "vc":DiscoverVC.init()],
            ["title":"我的","icon":"RD-tab-mine", "vc":MineVC.init()],

        ];

        
        for item in vcMaps {
//            self.title = item["title"] as? String
//            self.tabBar.itemSpacing = 10
            let title = item["title"] as? String
            self.tabBar.itemPositioning = .centered
            
            let vc = item["vc"] as? UIViewController;
            vc?.title = title
            let navVC = BaseNavigationController.init(rootViewController: vc!);
            navVC.tabBarItem.image = UIImage.init(named: item["icon"] as! String);
            navVC.tabBarItem.title = title
            self.addChild(navVC);

            
        }
//        self.tabBar.itemSpacing = 0.1;
//        self.tabBar.itemPositioning = .centered;
    }
    
}
