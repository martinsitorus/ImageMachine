//
//  MachineDataViewController.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 20/03/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit

class MachineDataViewController: ViewController {

    @IBOutlet weak var machineTable: UITableView!
    var machineArray:[MachineModel] = []
    var status:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        machineTable.reloadData()
    }
    func configureViews() {
        let addButton = UIBarButtonItem(title: "Add",
                                        style: UIBarButtonItem.Style.plain ,
                                        target: self, action: #selector(onAddClicked))
        
        self.navigationItem.rightBarButtonItem = addButton
        machineTable.register(MachineListTableViewCell.self, forCellReuseIdentifier: "machineListCell")
    }
    
    @objc func onAddClicked() {
        status = "add"
        performSegue(withIdentifier: "showMachineDetail", sender: self)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "showMachineDetail":
            let targetVC = segue.destination as! MachineDetailViewController
            targetVC.status = status
        default: break
        }
    }

}

extension MachineDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return machineArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "machineListCell") as! MachineListTableViewCell
        let machine = machineArray[indexPath.row]
        cell.machineName.text = machine.name
        cell.machineType.text = machine.type
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}
