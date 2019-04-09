//
//  MachineDetailViewController.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 21/03/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import TLPhotoPicker
import Photos
import IHKeyboardAvoiding


class imageMachineCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageMachineImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageMachineImageView.image = nil
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        imageMachineImageView.image = nil
    }
}

class MachineDetailViewController: ViewController {
    @IBOutlet weak var machinIdTextField: UITextField!
    @IBOutlet weak var machineNameTextField: UITextField!
    @IBOutlet weak var machineTypeTextField: UITextField!
    @IBOutlet weak var machineQRCodeTextField: UITextField!
    @IBOutlet weak var lastMaintenanceDateTextField: UITextField!
    @IBOutlet weak var imageThumbnailCollectionView: UICollectionView!
    @IBOutlet weak var machineImageButton: UIButton!
    let datePicker = UIDatePicker()
    
    var status:String = ""
    var selectedAssets = [TLPHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch status {
        case "add":
            statusAddNewMachine()
        default:
            statusDefault()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureViews()
    }
    
    func generateMachineId() -> String {
        return "1"
    }
    
    @objc func onDoneClicked() {
        checkTextField()
        /*
        let id = machinIdTextField.text
        let name = machineNameTextField.text
        let type = machineTypeTextField.text
        let qr = machineQRCodeTextField.text
        let date = lastMaintenanceDateTextField.text
        */
//        switch status {
//        case "add":
//            let newMachine = MachineModel.init(machineId: id!,
//                                               machineName: name!,
//                                               machineType: type!,
//                                               qrCode: qr!,
//                                               lastmaintenanceDate: date!,
//                                               images: selectedAssets,
//                                               thumbnail: thumbnailArray)
//            DataManager.addImageMachine(withModel: newMachine)
//            self.dismiss(animated: true, completion: nil)
//        default:
//            break
//        }
    }
    
    @objc func onEditClicked() {
        print("Done")
    }
    
    @IBAction func addImages(_ sender: Any) {
        let photosViewController = TLPhotosPickerViewController()
        photosViewController.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
            self?.showExceededMaximumAlert(vc: picker)
        }
        photosViewController.delegate = self
        
        var configure = TLPhotosPickerConfigure()
        configure.maxSelectedAssets = 10
        configure.allowedVideo = false
        configure.allowedVideoRecording = false
        photosViewController.configure = configure
        
        photosViewController.selectedAssets = self.selectedAssets
        
        self.present(photosViewController, animated: true, completion: nil)
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
    
    func showExceededMaximumAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "", message: "Exceed Maximum Number Of Selection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func configureViews() {
        KeyboardAvoiding.avoidingView = self.machineNameTextField
        KeyboardAvoiding.avoidingView = self.machineTypeTextField
        KeyboardAvoiding.avoidingView = self.machineQRCodeTextField
        
        showDatePicker()
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        lastMaintenanceDateTextField.inputAccessoryView = toolbar
        lastMaintenanceDateTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        lastMaintenanceDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    func checkTextField() {
        
        if machineNameTextField.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Alert", message: "Name Can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else if machineTypeTextField.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Alert", message: "Type Can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else if machineQRCodeTextField.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Alert", message: "QR Code Can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else if lastMaintenanceDateTextField.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Alert", message: "Please Set last Maintenance Date", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
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

extension MachineDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionCell", for: indexPath) as! imageMachineCollectionViewCell
        let phImage = selectedAssets[indexPath.row]
        cell.imageMachineImageView.image = phImage.fullResolutionImage!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: UIScreen.main.bounds.size.width / 2 - 5, height: 300)
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width / 2 - 5, height: 200)
        }
    }
}

extension MachineDetailViewController: TLPhotosPickerViewControllerDelegate {
    //TLPhotosPickerViewControllerDelegate
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        // use selected order, fullresolution image
        self.selectedAssets = withTLPHAssets
        imageThumbnailCollectionView.reloadData()
    }
    func dismissPhotoPicker(withPHAssets: [PHAsset]) {
        // if you want to used phasset.
    }
    func photoPickerDidCancel() {
        // cancel
    }
    func dismissComplete() {
        // picker viewcontroller dismiss completion
    }
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        // exceed max selection
        self.showExceededMaximumAlert(vc: picker)
    }
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        // handle denied albums permissions case
        picker.dismiss(animated: true) {
            let alert = UIAlertController(title: "", message: "Denied albums permissions granted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        // handle denied camera permissions case
        let alert = UIAlertController(title: "", message: "Denied camera permissions granted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        picker.present(alert, animated: true, completion: nil)
    }
}
