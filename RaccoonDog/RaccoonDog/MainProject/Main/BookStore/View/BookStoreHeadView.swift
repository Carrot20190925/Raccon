//
//  BookStoreHeadView.swift
//  RaccoonDog
//
//  Created by carrot on 30/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BookStoreHeadView: BaseReusableView {
    
    let titleLabel = UILabel.init()
    let actionBtn = ImageRightButton.init(type: .custom)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    

    }
    
    func initUI()  {
        let x : CGFloat = 16
        let y : CGFloat = 15
        titleLabel.textColor = TXTheme.eighthColor()
        titleLabel.font = TXTheme.thirdTitleFont(size: 18)
        titleLabel.text = "xx"
        titleLabel.frame = CGRect.init(x: x, y: y, width: 0, height: 0)
        titleLabel.sizeToFit()
        actionBtn.setTitle(RD_localized("换一批", ""), for: .normal)
        actionBtn.setTitleColor(TXTheme.tenthColor(), for: .normal)
        actionBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 15)
        actionBtn.setImage(UIImage.init(named: "rd_store_refresh")?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.addSubview(titleLabel)
        self.addSubview(actionBtn)
        actionBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleLabel.snp.centerY)
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
