//
//  Tool.swift
//  RaccoonDog
//
//  Created by carrot on 22/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation

func MyLog<T>(_ message : T,file:String = #file,function:String = #function,line:Int = #line) {
    let fileName = (file as NSString).lastPathComponent
    debugPrint("\(message)    File: \(fileName); Line : \(line); Function: \(function)")
}


func RD_localized(_ key : String,_ comment : String) -> String {
   return NSLocalizedString(key, comment: comment)
}
