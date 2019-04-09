//
//  HomeViewController.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 18/03/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class HomeViewController: ViewController {

    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.15, y: 0.3, width: 0.7, height: 0.4)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    var result: String = ""
    
    @IBAction func scanAction(_ sender: AnyObject) {
        readerVC.delegate = self
        readerVC.modalPresentationStyle = .formSheet
        
        present(readerVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (!isAppAlreadyLaunchedOnce()) {
            firstTimeRun()
        }
        // Do any additional setup after loading the view.
    }
    
    func firstTimeRun() {
        performSegue(withIdentifier: "showMachinData", sender: self)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension HomeViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        self.result = result.value
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
