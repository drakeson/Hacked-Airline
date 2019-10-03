//
//  HomeViewController.swift
//  Hacked Airline
//
//  Created by Dr. Drake 007 on 30/09/2019.
//  Copyright © 2019 Dr. Drake 007. All rights reserved.
//

import UIKit
import ADDatePicker
import Alamofire
import AlamofireImage
import PickerButton
import SPAlert

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ADDatePickerDelegate {

    var selectedFrom = ""
    var selectedTo = ""
    var selectedDate = ""
    @IBOutlet weak var airportsCollection: UICollectionView!
    @IBOutlet weak var fromAIr: PickerButton!
    @IBOutlet weak var toAir: PickerButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var datePickerView: ADDatePicker!
    
    var airport = [Airports]()
    let pickerDataSource = SinglePickerDetaSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Airports Collection View
        airportsCollection.delegate = self
        airportsCollection.dataSource = self
        
        datePicker()
        loadAirports()
        
        fromAIr.delegate = pickerDataSource
        fromAIr.dataSource = pickerDataSource
        toAir.delegate = pickerDataSource
        toAir.dataSource = pickerDataSource
    }
    
    
    
    func datePicker(){
        datePickerView.yearRange(inBetween: 2019, end: 2030)
        datePickerView.selectionType = .circle
        datePickerView.bgColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        datePickerView.deselectTextColor = UIColor.init(white: 1.0, alpha: 0.7)
        datePickerView.deselectedBgColor = .white
        datePickerView.selectedBgColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        datePickerView.deselectTextColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        datePickerView.selectedTextColor = .black
        datePickerView.intialDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        datePickerView.delegate = self
    }
    
    
    //::::: Delegates ::::://
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return airport.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "airports", for: indexPath) as! AirportsCollectionViewCell

        let air: Airports
        air = airport[indexPath.row]

        cell.airportId.text = air.idd
        cell.airportName.text = air.name
        cell.airportName.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.airportName.numberOfLines = 1

        Alamofire.request(air.imagz!).responseImage { response in
            if let image = response.result.value {cell.airportImg.image = image}
        }
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellName = self.airport[indexPath.item].name
        let cellId = self.airport[indexPath.item].idd
        fromAIr.setTitle(cellId!, for: .normal)
        SPAlert.present(title: cellName! , message: "Is selected as your deperture airport", preset: .done)
    }
    
    func ADDatePicker(didChange date: Date) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        btnDate.setTitle(dateformatter.string(from: date) , for: .normal)
    }
    
    
    //Buttons
    @IBAction func searchFlights(_ sender: Any) {
        self.selectedFrom = fromAIr.currentTitle!
        self.selectedTo = toAir.currentTitle!
        self.selectedDate = btnDate.currentTitle!
        self.performSegue(withIdentifier: "goToFlights", sender: self)
    }
    
    
    @IBAction func getDate(_ sender: Any) {
        let date = datePickerView.getSelectedDate()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        btnDate.setTitle(dateformatter.string(from: date) , for: .normal)
    }
    
    func loadAirports() {
        Alamofire.request(AppsUrls.airData).responseJSON { response in
            URLCache.shared.removeAllCachedResponses()
            if let json = response.result.value {
                let airArray : NSArray  = json as! NSArray
                for i in 0..<airArray.count{
                    self.airport.append(Airports(
                        idd: (airArray[i] as AnyObject).value(forKey: "id") as? String,
                        name: (airArray[i] as AnyObject).value(forKey: "name") as? String,
                        imagz: (airArray[i] as AnyObject).value(forKey: "pic") as? String
                    ))
                }
                self.airportsCollection.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let flightsVC = segue.destination as! FlightsViewController
        flightsVC.selectedFrom = self.selectedFrom
        flightsVC.selectedTo = self.selectedTo
        flightsVC.selectedDate = self.selectedDate
    }
    
    
}

