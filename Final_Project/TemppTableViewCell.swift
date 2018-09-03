//
//  TemppTableViewCell.swift
//  Final_Project
//
//  Created by mb on 06/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit

class TemppTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var km: UILabel!
    @IBOutlet weak var s1: UIImageView!
    @IBOutlet weak var s2: UIImageView!
    @IBOutlet weak var s3: UIImageView!
    @IBOutlet weak var s4: UIImageView!
    @IBOutlet weak var s5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
