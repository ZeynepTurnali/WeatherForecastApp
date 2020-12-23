//
//  CityWeatherDetailModel.swift
//  AppcentWeatherApp
//
//  Created by testinium on 21.12.2020.
//

import Foundation

struct CityWeatherDetailModel : Decodable {
    
    let consolidatedWeather : [ConsolidatedWeather]
    
    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
    }
    
    
}


struct ConsolidatedWeather : Decodable {
    let weatherStateName : String
    let applicableDate : String
    let weatherStateAbbr : String
    let theTemp : Double
    
    enum CodingKeys: String, CodingKey {
        case weatherStateName = "weather_state_name"
        case applicableDate = "applicable_date"
        case weatherStateAbbr = "weather_state_abbr"
        case theTemp = "the_temp"
    }
}
