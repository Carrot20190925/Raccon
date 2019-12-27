//
//  BaseView.swift
//  RaccoonDog
//
//  Created by carrot on 27/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BaseView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviews() {}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
