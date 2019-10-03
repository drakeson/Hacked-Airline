//
//  FlightsViewController.swift
//  Hacked Airline
//
//  Created by Dr. Drake 007 on 28/09/2019.
//  Copyright © 2019 Dr. Drake 007. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FlightsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var flightTable: UITableView!
    var flight = [Flights]()
    var fly = [Fly]()
    var selectedFrom: String?
    var selectedTo: String?
    var selectedDate: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flightTable.dataSource = self
        flightTable.dataSource = self
        
        let finalURL = selectedFrom! + "/" + selectedTo! + "/" + selectedDate! + "?directFlights=0&limit=10"
        loadFlights(url: finalURL)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flight.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flights", for: indexPath) as! FlightsTableViewCell
        //Using ObjectMapper
//        cell.fromC.text = fly[indexPath.row].airFrm!
//        cell.fromT.text = fly[indexPath.row].tymFrm!
//        cell.toC.text = fly[indexPath.row].airTo!
//        cell.toT.text = fly[indexPath.row].tymTo!
        
        let flz: Flights
        flz = flight[indexPath.row]

        cell.fromC.text = flz.fromAir
        cell.fromT.text = flz.fromTym
        cell.toC.text = flz.toAir
        cell.toT.text = flz.toTym
        //cell.terminal.text = "Terminal  \(fly.terminalNum!)"
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.selectedItem = self.requires[indexPath.row]
        self.performSegue(withIdentifier: "flightDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let detailViewController = segue.destination as! MapViewController
//        detailViewController.selectedItem = self.selectedItem
    }
    
    func loadFlights(url: String) {
        
        Alamofire.request(AppsUrls.flightsData + url,method: .get, headers:APIManager.headers()).responseJSON { response in
            let swiftyJsonVar = JSON(response.result.value!)
            
            print(swiftyJsonVar)
            let scheduleJson = swiftyJsonVar["ScheduleResource"]["Schedule"]

            let departFrom = swiftyJsonVar["ScheduleResource"]["Schedule"]["Flight"]["Departure"]["AirportCode"].string
            let arriveTo = swiftyJsonVar["ScheduleResource"]["Schedule"]["Flight"]["Arrival"]["AirportCode"].string
            let departTym = swiftyJsonVar["ScheduleResource"]["Schedule"]["Flight"]["Departure"]["ScheduledTimeLocal"]["DateTime"].string
            let arriveTym = swiftyJsonVar["ScheduleResource"]["Schedule"]["Flight"]["Arrival"]["ScheduledTimeLocal"]["DateTime"].string

//            for i in 0..<scheduleJson.count{
//                //adding hero values to the hero list
//                self.flight.append(Flights(
//                    fromAir: (scheduleJson[i] as AnyObject).value(forAttribute: departFrom!) as? String,
//                    fromTym: (scheduleJson[i] as AnyObject).value(forKey: arriveTo!) as? String,
//                    toAir: (scheduleJson[i] as AnyObject).value(forKey: departTym!) as? String,
//                    toTym: (scheduleJson[i] as AnyObject).value(forKey: arriveTym!) as? String
//                ))
//            }
            self.flightTable.reloadData()
            
            
        }

    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
