//
//  BookDetailListCell.swift
//  RaccoonDog
//
//  Created by carrot on 30/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BookDetailListCell: BaseCollectionCell {

    @IBOutlet weak var topSegment: UIView!
    @IBOutlet weak var secondBtn: ImageRightButton!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var bottomSegment: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.firstBtn.isUserInteractionEnabled = false
        self.secondBtn.isUserInteractionEnabled = false
        self.firstBtn.setTitleColor(TXTheme.eighthColor(), for: .normal)
        self.firstBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 14)
        self.secondBtn.setTitleColor(TXTheme.tenthColor(), for: .normal)
        self.secondBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 11)
        self.topSegment.backgroundColor = TXTheme.ninthColor()
        self.bottomSegment.backgroundColor = TXTheme.thirdColor()
        // Initialization code
    }

}
