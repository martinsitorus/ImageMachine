//
//  DataManager.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 01/04/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    static let sharedManager = DataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ImageMachine")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = DataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insertMachine(withMachineModel: MachineModel)->ImageMachineModel? {
        
        let managedContext = DataManager.sharedManager.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "ImageMachineModel",
                                                in: managedContext)!

        let imageMachine = NSManagedObject(entity: entity,
                                           insertInto: managedContext)

        imageMachine.setValue(withMachineModel.id, forKeyPath: "id")
        imageMachine.setValue(withMachineModel.name, forKeyPath: "name")
        imageMachine.setValue(withMachineModel.type, forKeyPath: "type")
        imageMachine.setValue(withMachineModel.maintenanceDate, forKeyPath: "maintenanceDate")
        imageMachine.setValue(withMachineModel.qrCodeNumber, forKeyPath: "qrcode")
        imageMachine.setValue(withMachineModel.imageArray, forKeyPath: "imageArray")
        

        do {
            try managedContext.save()
            return imageMachine as? ImageMachineModel
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func updateMachine(withMachineModel: MachineModel, andImageMachine: ImageMachineModel) {

        let context = DataManager.sharedManager.persistentContainer.viewContext
        
        do {
            andImageMachine.setValue(withMachineModel.id, forKeyPath: "id")
            andImageMachine.setValue(withMachineModel.name, forKeyPath: "name")
            andImageMachine.setValue(withMachineModel.type, forKeyPath: "type")
            andImageMachine.setValue(withMachineModel.maintenanceDate, forKeyPath: "maintenanceDate")
            andImageMachine.setValue(withMachineModel.qrCodeNumber, forKeyPath: "qrcode")
            andImageMachine.setValue(withMachineModel.imageArray, forKeyPath: "imageArray")
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    func deleteMachine(withImageMachine: ImageMachineModel){

        let managedContext = DataManager.sharedManager.persistentContainer.viewContext
        
        do {
            managedContext.delete(withImageMachine)
        } catch {
            // Do something in response to error condition
            print(error)
        }
        do {
            try managedContext.save()
        } catch {
            // Do something in response to error condition
        }
    }
    
    func fetchAllImageMachine() -> [ImageMachineModel]?{

        let managedContext = DataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ImageMachineModel")
        do {
            let imageMachine = try managedContext.fetch(fetchRequest)
            return imageMachine as? [ImageMachineModel]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func deleteById(id: String) -> [ImageMachineModel]? {
        /*get reference to appdelegate file*/
        
        
        /*get reference of managed object context*/
        let managedContext = DataManager.sharedManager.persistentContainer.viewContext
        
        /*init fetch request*/
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ImageMachineModel")
        fetchRequest.predicate = NSPredicate(format: "id == %@" ,id)
        do {
            let item = try managedContext.fetch(fetchRequest)
            var arrRemovedPeople = [ImageMachineModel]()
            for i in item {
                managedContext.delete(i)
                try managedContext.save()
                arrRemovedPeople.append(i as! ImageMachineModel)
            }
            return arrRemovedPeople
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
}
