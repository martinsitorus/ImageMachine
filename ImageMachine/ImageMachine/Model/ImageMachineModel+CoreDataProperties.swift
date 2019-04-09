//
//  ImageMachineModel+CoreDataProperties.swift
//  
//
//  Created by Martin Sitorus on 05/04/19.
//
//

import Foundation
import CoreData


extension ImageMachineModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageMachineModel> {
        return NSFetchRequest<ImageMachineModel>(entityName: "ImageMachineModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var qrcode: Int16
    @NSManaged public var maintenanceDate: NSDate?
    @NSManaged public var imageArray: NSObject?

}
