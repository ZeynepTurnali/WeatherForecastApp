
//  WeatherDataModel.swift
//  AppcentWeatherApp


import Foundation

struct WeatherDataModel : Decodable {
    
    let title: String
    let locationType: String
    let latLong: String
    let woeid: Int
    let distance: Int?

    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case locationType = "location_type"
        case latLong = "latt_long"
        case woeid = "woeid"
        case distance = "distance"
    }
    
}




