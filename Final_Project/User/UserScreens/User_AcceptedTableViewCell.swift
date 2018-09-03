//
//  User_AcceptedTableViewCell.swift
//  Final_Project
//
//  Created by mb on 01/07/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit

class User_AcceptedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Lblname: UILabel!
    
    @IBOutlet weak var Lblservice: UILabel!
    
    @IBOutlet weak var Lbltime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
