//
//  SinglePickerDetaSource.swift
//  Hacked Airline
//
//  Created by Dr. Drake 007 on 30/09/2019.
//  Copyright © 2019 Dr. Drake 007. All rights reserved.
//

import UIKit
import PickerButton

class SinglePickerDetaSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerValues: [String] = ["FRA", "ZRH", "JFK", "LAX", "YAT", "EBB"]

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }

}
