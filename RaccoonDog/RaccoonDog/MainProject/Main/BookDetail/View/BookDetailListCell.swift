//
//  BookDetailListCell.swift
//  RaccoonDog
//
//  Created by carrot on 30/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BookDetailListCell: BaseCollectionCell {

    @IBOutlet weak var secondBtn: ImageRightButton!
    @IBOutlet weak var firstBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.firstBtn.setTitleColor(TXTheme.eighthColor(), for: .normal)
        self.firstBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 14)
        self.secondBtn.setTitleColor(TXTheme.tenthColor(), for: .normal)
        self.secondBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 11)
        // Initialization code
    }

}
