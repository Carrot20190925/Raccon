//
//  ImageRightButton.swift
//  RaccoonDog
//
//  Created by carrot on 30/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class ImageRightButton: UIButton {

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageRect = super.imageRect(forContentRect: contentRect)
        if imageRect.size.width  > 0   {
            return CGRect.init(x: imageRect.origin.x, y: titleRect.origin.y, width: titleRect.size.width, height: titleRect.size.height)

        }
        return titleRect
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageRect = super.imageRect(forContentRect: contentRect)
        
        if titleRect.size.width > 0{
            return CGRect.init(x: imageRect.origin.x + titleRect.size.width, y: imageRect.origin.y, width: imageRect.size.width, height: imageRect.size.height)
        }
        return imageRect
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
