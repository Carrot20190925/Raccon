//
//  BannerImageView.swift
//  RaccoonDog
//
//  Created by carrot on 28/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BannerImageView: UIImageView {

    let label = UILabel.init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label.frame = self.bounds
        self.addSubview(self.label)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
