//
//  FlightsTableViewCell.swift
//  Hacked Airline
//
//  Created by Dr. Drake 007 on 28/09/2019.
//  Copyright © 2019 Dr. Drake 007. All rights reserved.
//

import UIKit

class FlightsTableViewCell: UITableViewCell {

    @IBOutlet weak var fromC: UILabel!
    @IBOutlet weak var toC: UILabel!
    @IBOutlet weak var fromT: UILabel!
    @IBOutlet weak var toT: UILabel!
    @IBOutlet weak var terminal: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
