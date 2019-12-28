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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    
    func initUI()  {
        self.bannerView = BannerView.init(frame: self.bounds)
        self.bannerView.models = ["ccc","d","xxxx"]
        self.addSubview(self.bannerView)
        self.categoryView = UIView.init(frame: <#T##CGRect#>)
    }
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
