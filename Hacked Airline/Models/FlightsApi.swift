//
//  FlightsApi.swift
//  Hacked Airline
//
//  Created by Dr. Drake 007 on 03/10/2019.
//  Copyright © 2019 Dr. Drake 007. All rights reserved.
//

import Foundation
import ObjectMapper

class FlightsApi: Mappable {
    
    var schedule: [Fly]?
    
    
    required init?(map: Map) {
        //scheduleDepart[0].air
    }
    
    func mapping(map: Map) {
        schedule <- map["ScheduleResource"]["Schedule"]["Flight"]
    }
}

class Fly: Mappable {
    var airFrm : String?
    var tymFrm : String?
    var airTo : String?
    var tymTo : String?
    //var term : Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        airFrm <- map["Departure"]["AirportCode"]
        tymFrm <- map["Departure"]["ScheduledTimeLocal"]["DateTime"]
        airTo <- map["Arrival"]["AirportCode"]
        tymTo <- map["Arrival"]["ScheduledTimeLocal"]["DateTime"]
        //term <- map["ScheduleResource"]["Schedule"]["Flight"]["Arrival"]
    }
}

