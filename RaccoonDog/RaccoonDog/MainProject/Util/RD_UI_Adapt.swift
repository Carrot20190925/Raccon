//
//  RD_UI_Adapt.swift
//  RaccoonDog
//
//  Created by carrot on 26/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation

let rScreenWidth = UIScreen.main.bounds.size.width
let rScreenHeight = UIScreen.main.bounds.size.height

func RD_SIZE(_ size : CGFloat) -> CGFloat {
    return size * (rScreenWidth / 375.0)
}
