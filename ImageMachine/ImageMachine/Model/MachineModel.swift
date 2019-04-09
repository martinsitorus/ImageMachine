//
//  MachineModel.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 20/03/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit
import Photos
import TLPhotoPicker

class MachineModel: NSObject {
    var id:String
    var name:String
    var type:String
    var qrCodeNumber: String
    var maintenanceDate: NSDate
    var imageArray:[PHAsset]
    
    init(machineId:String, machineName:String, machineType:String, qrCode: String, lastmaintenanceDate: NSDate, images:[PHAsset]) {
        self.id = machineId
        self.name = machineName
        self.type = machineType
        self.qrCodeNumber = qrCode
        self.maintenanceDate = lastmaintenanceDate
        self.imageArray = images
    }
    
    
}
