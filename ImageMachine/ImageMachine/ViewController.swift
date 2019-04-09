//
//  ViewController.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 06/03/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    func saveToCoreData(withModel: MachineModel) {
        let imageMachine = DataManager.sharedManager.insertMachine(withMachineModel: withModel)
        if imageMachine != nil {
            let alert = UIAlertController(title: "Alert", message: "Data Saved Succesfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateToCoreData(withMachineModel: MachineModel, andImageMachine: ImageMachineModel) {
        DataManager.sharedManager.updateMachine(withMachineModel: withMachineModel, andImageMachine: andImageMachine)
    }
    
    func deleteFromCoreData(withImageMachine : ImageMachineModel){
        DataManager.sharedManager.deleteMachine(withImageMachine: withImageMachine)
    }
    
    func fetchAllFromCoreData() -> [ImageMachineModel]? {
        return DataManager.sharedManager.fetchAllImageMachine()
    }
    
    func deleteByIdFromCoreData(id: String) {
        
        let arrRemovedObjects = DataManager.sharedManager.deleteById(id: id)
    }
}
