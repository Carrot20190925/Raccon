//
//  BookStoreSecondCell.swift
//  RaccoonDog
//
//  Created by carrot on 28/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BookStoreSecondCell: BaseCollectionCell {
    let avatarImage = UIImageView.init()
    let bookNameLabel = UILabel.init()
    let bookAuthorLabel = UILabel.init()
    let bookDescLabel = UILabel.init()
    let bookScoreLabel = UILabel.init()
    let segmentView = UIView.init()
    let backSegmentView = UIView.init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    
    private func initUI(){
        self.avatarImage.layer.cornerRadius = 10
        self.avatarImage.clipsToBounds = true
        self.bookNameLabel.textColor = TXTheme.eighthColor()
        self.bookNameLabel.font = TXTheme.thirdTitleFont(size: 15)
        self.segmentView.backgroundColor = TXTheme.ninthColor()
        self.bookAuthorLabel.textColor = TXTheme.tenthColor()
        self.bookAuthorLabel.font = TXTheme.thirdTitleFont(size: 11)
        self.bookScoreLabel.textColor = TXTheme.eleventhColor()
        self.bookScoreLabel.font = TXTheme.thirdTitleFont(size: 12)
        self.bookScoreLabel.layer.borderWidth = 0.5
        self.bookScoreLabel.layer.borderColor = TXTheme.eleventhColor().cgColor
        self.bookScoreLabel.layer.cornerRadius = 10
        self.bookScoreLabel.clipsToBounds = true
        self.bookDescLabel.textColor = TXTheme.seventhColor()
        self.bookDescLabel.numberOfLines = 3
        self.bookDescLabel.font = TXTheme.thirdTitleFont(size: 14)
        self.backSegmentView.backgroundColor = TXTheme.thirdColor()
        self.avatarImage.backgroundColor = UIColor.gray
        self.bookScoreLabel.textAlignment = .center
        self.bookNameLabel.text = "xxx"
        self.bookScoreLabel.text = "xxx"
        self.bookAuthorLabel.text = "xxx"
        self.bookDescLabel.text = "xxx"
//        self.bookNameLabel.text = "xxx"

        
        self.addSubview(self.avatarImage)
        self.addSubview(self.bookNameLabel)
        self.addSubview(self.bookDescLabel)
        self.addSubview(self.bookAuthorLabel)
        self.addSubview(self.segmentView)
        self.addSubview(self.bookScoreLabel)
        self.addSubview(self.backSegmentView)
        let imageW = (rScreenWidth - 55) / 3.0
        let imageH = imageW * 130.0/108.0
        let space = 15
        avatarImage.snp.makeConstraints {(make) in
            make.width.equalTo(imageW)
            make.height.equalTo(imageH)
            make.top.equalTo(10)
            make.left.equalTo(space)
        }
        
        bookNameLabel.snp.makeConstraints {[weak self] (make) in
            make.top.equalTo(self?.avatarImage.snp.top ?? 0)
            make.left.equalTo(self?.avatarImage.snp.right ?? 0).offset(10)
            make.right.equalToSuperview().offset(-space)
        }
        
        
        bookDescLabel.snp.makeConstraints {[weak self] (make) in
            make.top.equalTo(self?.bookNameLabel.snp.bottom ?? 0).offset(6)
            make.left.equalTo(self?.avatarImage.snp.right ?? 0).offset(10)
            make.right.equalToSuperview().offset(-space)
        }
        
        bookScoreLabel.snp.makeConstraints {[weak self] (make) in
            make.right.equalToSuperview().offset(-space)
            make.bottom.equalTo(self?.avatarImage.snp.bottom ?? 0)
            make.width.equalTo(50)
            make.height.equalTo(20)
            
        }
        bookAuthorLabel.snp.makeConstraints { [weak self](make) in
            make.left.equalTo(self?.avatarImage.snp.right ?? 0).offset(10)
            make.right.equalTo(self?.bookScoreLabel.snp.left ?? 0 ).offset(10)
            make.centerY.equalTo(self?.bookScoreLabel.snp.centerY ?? 0)
        }
        
        segmentView.snp.makeConstraints {[weak self] (make) in
            make.bottom.equalTo(self?.bookScoreLabel.snp.top ?? 0).offset(-space)
            make.left.equalTo(self?.avatarImage.snp.right ?? 0).offset(10)
            make.right.equalToSuperview().offset(-space)
            make.height.equalTo(0.5)

        }
        
        backSegmentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(10)
            make.top.equalTo(avatarImage.snp.bottom).offset(15)
        }
//        self.backgroundColor = TXTheme.thirdColor()
//        self.contentView.backgroundColor = UIColor.white
        
    }
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
