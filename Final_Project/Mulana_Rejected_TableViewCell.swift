//
//  Mulana_Rejected_TableViewCell.swift
//  Final_Project
//
//  Created by mb on 01/07/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit

class Mulana_Rejected_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var Lbl_Name: UILabel!
    
    @IBOutlet weak var Lbl_Service: UILabel!
    
    @IBOutlet weak var Lbl_Time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
