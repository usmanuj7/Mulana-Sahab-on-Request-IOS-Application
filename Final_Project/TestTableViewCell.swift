//
//  TestTableViewCell.swift
//  Final_Project
//
//  Created by Muhammad Usman on 28/07/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet var userId: UILabel!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var body: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
