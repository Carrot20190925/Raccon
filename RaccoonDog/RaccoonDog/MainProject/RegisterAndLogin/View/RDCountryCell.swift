//
//  RDCountryCell.swift
//  RaccoonDog
//
//  Created by carrot on 23/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class RDCountryCell: BaseTableCell {

    @IBOutlet var callCodeLabel: UILabel!
    @IBOutlet var countryNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.callCodeLabel.textColor = TXTheme.fifthColor()
        self.callCodeLabel.backgroundColor = TXTheme.thirdColor()
        self.callCodeLabel.font = TXTheme.thirdTitleFont(size: 12)
        self.countryNameLabel.textColor = TXTheme.sixthColor()
        self.countryNameLabel.font = TXTheme.thirdTitleFont(size: 14)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
