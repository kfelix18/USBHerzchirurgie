//
//  DienstplanTableViewCell.swift
//  USBHerzchirurgie
//
//  Created by Felix on 30/12/14.
//  Copyright (c) 2014 Felix. All rights reserved.
//

import UIKit

class DienstplanTableViewCell: UITableViewCell {

    @IBOutlet weak var dienstAAundOA: UILabel!
    @IBOutlet weak var abwesend: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
