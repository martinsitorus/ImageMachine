//
//  DataManager.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 01/04/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit
import StorageManager

class DataManager: NSObject {

    func storeImageMachineArray(withArray: [MachineModel]) {
        try! StorageManager.default.store(array: withArray, in: "imageMachineArray")
    }
    func getImageMachineArray() -> [MachineModel] {
        let exampleArray: [MachineModel] = try! StorageManager.default.arrayValue("exampleArray")
        return exampleArray
    }
}
