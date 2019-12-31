//
//  CategoryCell.swift
//  RaccoonDog
//
//  Created by carrot on 30/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class CategoryCell: BaseCollectionCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var subjectLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.layer.cornerRadius = 10
//        self.backView.clipsToBounds = true
        self.backView.layer.shadowColor = TXTheme.rgbColor(0, 0, 0, 0.09).cgColor
        self.backView.layer.shadowOpacity = 1.0
        self.backView.layer.shadowOffset = CGSize.init(width: 0, height: 0 )
        self.backView.layer.shadowRadius = 4
        
        self.backView.backgroundColor = TXTheme.categoryBackColor()
        self.categoryLabel.textColor = TXTheme.categoryTitleColor()
        self.subjectLabel.textColor = TXTheme.tenthColor()
        self.categoryLabel.font = TXTheme.thirdTitleFont(size: 18)
        self.subjectLabel.font = TXTheme.thirdTitleFont(size: 11)
        // Initialization code
    }
    
    
    
    
    

}
