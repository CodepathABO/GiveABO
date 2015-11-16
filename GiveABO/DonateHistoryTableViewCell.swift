//
//  DonateHistoryTableViewCell.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class DonateHistoryTableViewCell: UITableViewCell {


    @IBOutlet weak var bloodTypeLetter: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeTextLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
