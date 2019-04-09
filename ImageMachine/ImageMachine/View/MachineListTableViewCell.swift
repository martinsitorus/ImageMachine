//
//  MachineListTableViewCell.swift
//  ImageMachine
//
//  Created by Martin Sitorus on 01/04/19.
//  Copyright © 2019 Martin Sitorus. All rights reserved.
//

import UIKit

class MachineListTableViewCell: UITableViewCell {
    @IBOutlet weak var machineName: UILabel!
    @IBOutlet weak var machineType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
