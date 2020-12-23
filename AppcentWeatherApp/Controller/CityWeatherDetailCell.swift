//
//  CityWeatherDetailCell.swift
//  AppcentWeatherApp

import UIKit

class CityWeatherDetailCell: UITableViewCell {

    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    
    func setView(weatherState : String, date : String, temp: String, weatherDetail: String){
        
        tempLabel.text = "\(temp)°"
        weatherStateLabel.text = weatherDetail
        
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"
        let showDate = dateFormatterInput.date(from: date)
        dateFormatterInput.dateFormat = "MM/dd/yyyy"
        dateLabel.text = dateFormatterInput.string(from: showDate!)
        
        switch (weatherState) {
        case "sn":
            detailImageView.image = UIImage(named: "snow")
        case "sl":
            detailImageView.image = UIImage(named: "sleet")
        case "h":
            detailImageView.image = UIImage(named: "hail")
        case "t":
            detailImageView.image = UIImage(named: "thunderstorm")
        case "hr":
            detailImageView.image = UIImage(named: "heavyRain")
        case "lr":
            detailImageView.image = UIImage(named: "lightRain")
        case "s":
            detailImageView.image = UIImage(named: "showers")
        case "hc":
            detailImageView.image = UIImage(named: "heavyCloud")
        case "lc":
            detailImageView.image = UIImage(named: "lightCloud")
        case "c":
            detailImageView.image = UIImage(named: "clear")
        default:
            detailImageView.image = UIImage(named: "canNotLoad")
        }
    }
    
}
