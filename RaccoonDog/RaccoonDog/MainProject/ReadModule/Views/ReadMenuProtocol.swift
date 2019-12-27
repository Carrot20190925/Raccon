//
//  ReadMenuProtocol.swift
//  RaccoonDog
//
//  Created by carrot on 27/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import Foundation

protocol ReadMenuProtocol:NSObjectProtocol {
    func backAction();
    ///改变日夜模式
    func changeDayNight()
    ///目录展示
    func showList()
    ///设置展示
    func showSet()


}

extension ReadMenuProtocol{
    func backAction(){}
    ///改变日夜模式
    func changeDayNight(){}
    ///目录展示
    func showList(){}
    ///设置展示
    func showSet(){}
}
