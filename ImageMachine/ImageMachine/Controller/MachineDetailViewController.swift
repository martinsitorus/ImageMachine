//
//  MachineDetailViewController.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 21/03/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit

class MachineDetailViewController: ViewController {
    @IBOutlet weak var machinIdTextField: UITextField!
    @IBOutlet weak var machineNameTextField: UITextField!
    @IBOutlet weak var machineTypeTextField: UITextField!
    @IBOutlet weak var machineQRCodeTextField: UITextField!
    @IBOutlet weak var lastMaintenanceDateTextField: UITextField!
    @IBOutlet weak var imageThumbnailCollectionView: UICollectionView!
    @IBOutlet weak var machineImageButton: UIButton!
    
    var status:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch status {
        case "add":
            statusAddNewMachine()
        default:
            statusDefault()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func statusAddNewMachine() {
        machinIdTextField.isEnabled = false
        machinIdTextField.text = generateMachineId()
        machineNameTextField.isEnabled = true
        machineTypeTextField.isEnabled = true
        machineQRCodeTextField.isEnabled = true
        lastMaintenanceDateTextField.isEnabled = true
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItem.Style.plain ,
                                         target: self, action: #selector(onDoneClicked))
        
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func statusDefault() {
        machinIdTextField.isEnabled = false
        machineNameTextField.isEnabled = false
        machineTypeTextField.isEnabled = false
        machineQRCodeTextField.isEnabled = false
        lastMaintenanceDateTextField.isEnabled = false
        
        let editButton = UIBarButtonItem(title: "Edit",
                                         style: UIBarButtonItem.Style.plain ,
                                         target: self, action: #selector(onEditClicked))
        
        self.navigationItem.rightBarButtonItem = editButton
    }
    func generateMachineId() -> String {
        return "1"
    }
    
    @objc func onDoneClicked() {
        print("Done")
    }
    
    @objc func onEditClicked() {
        print("Done")
    }

}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

//extension MachineDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//}
