//
//  AppHelper.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 02/04/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit

class AppHelper: NSObject {
    
}
func isAppAlreadyLaunchedOnce()->Bool{
    let defaults = UserDefaults.standard
    if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
        print("App already launched")
        return true
    }else{
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        print("App launched first time")
        return false
    }
}
