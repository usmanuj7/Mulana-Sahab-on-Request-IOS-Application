//
//  ReqTableViewCell.swift
//  Final_Project
//
//  Created by mb on 07/06/2018.
//  Copyright © 2018 mb. All rights reserved.
//

import UIKit

class ReqTableViewCell: UITableViewCell {

    @IBOutlet weak var Btn_Direction: UIButton!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var servies: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
