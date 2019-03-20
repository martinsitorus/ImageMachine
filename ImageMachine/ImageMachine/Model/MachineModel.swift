//
//  MachineModel.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 20/03/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit

class MachineModel: NSObject {
    var id:String
    var name:String
    var type:String
    var qrCodeNumber: String
    var maintenanceDate: NSDate
    var imageArray:[UIImage]
    
    
    init(machineId:String, machineName:String, machineType:String, qrCode: String, lastmaintenanceDate: NSDate, images:[UIImage]) {
        self.id = machineId
        self.name = machineName
        self.type = machineType
        self.qrCodeNumber = qrCode
        self.maintenanceDate = lastmaintenanceDate
        self.imageArray = images
    }
    
    
}
