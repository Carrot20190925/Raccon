//
//  BookStoreFirstCell.swift
//  RaccoonDog
//
//  Created by carrot on 24/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit
class BookStoreFirstCell: BaseCollectionCell {
    let avatarImage = UIImageView.init()
    let bookNameLabel = UILabel.init()
    let bookAuthorLabel = UILabel.init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    
    }

    func initUI() {
        self.addSubview(avatarImage)
        self.addSubview(bookNameLabel)
        self.addSubview(bookAuthorLabel)
        avatarImage.layer.cornerRadius = 10
        avatarImage.clipsToBounds = true
        avatarImage.backgroundColor = UIColor.lightGray
        self.bookAuthorLabel.text = "xxx"
        self.bookNameLabel.text = "xxx"

        avatarImage.snp.makeConstraints { (make) in
            make.bottom.equalTo(bookNameLabel.snp.top).offset(-10)
            make.height.equalTo(avatarImage.snp.width).multipliedBy(130.0/108.0)
            make.top.left.right.equalToSuperview()
        }
        bookAuthorLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
        }
        bookNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(bookAuthorLabel.snp.top).offset(-10)
            make.left.equalToSuperview().offset(10)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
