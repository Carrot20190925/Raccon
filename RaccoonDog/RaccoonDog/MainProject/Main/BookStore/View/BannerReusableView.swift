//
//  BannerReusableView.swift
//  RaccoonDog
//
//  Created by carrot on 28/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BannerReusableView: BaseReusableView {
    var bannerView: BannerView!
    var categoryView : UIView!
    
    var selectedCategory : ((_ type : Int ) -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    
    func initUI()  {
        var x : CGFloat = 16
        var y : CGFloat = 0
        var width = self.mj_w  - x * 2;
        var height = width * 150.0/343.0
        self.bannerView = BannerView.init(frame: CGRect.init(x: x, y: y, width: width, height: height))
        self.bannerView.backgroundColor = UIColor.green
        self.bannerView.layer.cornerRadius = 10
        self.bannerView.clipsToBounds = true
        self.bannerView.models = ["ccc","d","xxxx"]
        self.addSubview(self.bannerView)
        x = 0
        width = self.mj_w
        y = height
        height = self.mj_h - height
        
        
        self.categoryView = UIView.init(frame: CGRect.init(x: x, y: y, width: width, height: height))
        self.addSubview(self.categoryView)
        let categorys = ["分类","榜单","完结","出版"]
        let images = ["rd_category","rd_rank","rd_finish","rd_published"]
        width = width / CGFloat.init(integerLiteral: categorys.count)
        y = height - 30
        
        
        for (index,title) in categorys.enumerated() {
            let label = UILabel.init(frame: CGRect.init(x: CGFloat.init(integerLiteral: index) * width, y: y, width: width, height: 20))
            label.textAlignment = NSTextAlignment.center
            label.text = title
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: 0, y: 0, width: 36, height: 36)
            button.center = CGPoint.init(x: label.center.x, y: label.center.y - 50)
            button.setImage(UIImage.init(named: images[index]), for: .normal)
            button.addTarget(self, action: #selector(selectedCategroyAction(sender:)), for: .touchUpInside)
            button.tag = index
            self.categoryView.addSubview(label)
            self.categoryView.addSubview(button)
        }
        
    }
    
    @objc func selectedCategroyAction(sender:UIButton){
        self.selectedCategory?(sender.tag)
    }
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
