//
//  ViewController.swift
//  AppcentWeatherApp

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    private var loading = false
    
    var citysArray = [String]()
    var selectedCity : String = ""
    
    var cityWoeidArray = [Int]()
    var selectedCityWoeid : Int = 0
    
    let locationManager = CLLocationManager()
    
    
    var weatherUrl = URL(string: "https://www.metaweather.com//api/location/search/?lattlong=")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            getData(lon: String(location.coordinate.longitude), lat: String(location.coordinate.latitude))
        }
    }
    
    func getData(lon: String, lat: String){
        let url = "\(weatherUrl)" + "\(lon)" + "," + "\(lat)"
        let request = AF.request(url).validate()
        request.responseJSON {(data) in
            //  print(data)
        }
        
        let encodedResponse = AF.request(url)
            .responseData { (response) in
                guard let model = response.value else { return }
                let utf8Text = String(data: model, encoding: .utf8) ?? String(decoding: model, as: UTF8.self)
                //  print(utf8Text)
            }
        
        encodedResponse.validate()
            .responseDecodable(of: [WeatherDataModel].self){ (response) in
                switch response.result {
                case .success(let models):
                    for model in models {
                        self.citysArray.append(model.title)
                        self.cityWoeidArray.append(model.woeid)
            
                        self.loading = true
                    }
                    print(self.citysArray)
            
                    if self.loading {
                        
                        DispatchQueue.main.async {
                        
                            self.tableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error)
                    
                }
                
            }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading {
            return citysArray.count
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if loading {
            cell.textLabel?.text = citysArray[indexPath.row]
        } else {
            cell.textLabel?.text = "loading..."
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = citysArray[indexPath.row]
        selectedCityWoeid = cityWoeidArray[indexPath.row]
        self.performSegue(withIdentifier: "cityDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cityDetailVC" {
            let cityWeatherDetail = segue.destination as! CityWeatherDetailViewController
            cityWeatherDetail.chosenCity = selectedCity
            cityWeatherDetail.chosenWoeid = selectedCityWoeid
           
        }
    }
    
    
}

