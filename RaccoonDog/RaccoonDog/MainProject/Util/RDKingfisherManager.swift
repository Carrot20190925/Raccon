//
//  RDKingfisherManager.swift
//  RaccoonDog
//
//  Created by carrot on 24/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation
import Kingfisher
extension UIImageView{
    func setImage(urlString:String) {
        if  let url = URL.init(string: urlString){
            let source = ImageResource.init(downloadURL: url)
            self.kf.setImage(with: source)
        }



    }
}
