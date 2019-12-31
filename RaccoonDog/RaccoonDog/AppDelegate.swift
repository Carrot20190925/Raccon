//
//  AppDelegate.swift
//  RaccoonDog
//
//  Created by carrot on 22/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit
let RD_Resign_Active_Notification = "RD_Resign_Active_Notification"
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        if let localAccount = RDAccountManager.share.localAccount() {
            self.window?.rootViewController = BaseTabBarController.init()
        }else{
            let loginVC = RDLoginController.init()
            let nav = BaseNavigationController.init(rootViewController: loginVC)
            self.window?.rootViewController = nav
        }
        self.window?.makeKeyAndVisible()
        

//        MyLog("保存失败")
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name.init(RD_Resign_Active_Notification), object: nil)
    }
    
    
    
    
    
    
    





}

