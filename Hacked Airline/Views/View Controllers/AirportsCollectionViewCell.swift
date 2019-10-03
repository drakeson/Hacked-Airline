//
//  AirportsCollectionViewCell.swift
//  Hacked Airline
//
//  Created by Dr. Drake 007 on 28/09/2019.
//  Copyright © 2019 Dr. Drake 007. All rights reserved.
//

import UIKit

class AirportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var airportImg: UIImageView!
    @IBOutlet weak var airportName: UILabel!
    @IBOutlet weak var airportId: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        airportImg.layer.cornerRadius = 10
        airportImg.layer.borderWidth = 0.5
        //airportImg.layer.borderColor = UIColor.black as! CGColor
    }
    
    
    
}
