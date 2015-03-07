//
//  TableViewCell.swift
//  TripHack
//
//  Created by Richard Kim on 3/6/15.
//  Copyright (c) 2015 MarinaLLC. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var tripButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
