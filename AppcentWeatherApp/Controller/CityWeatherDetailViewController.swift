//
//  CityWeatherDetaiViewController.swift
//  AppcentWeatherApp

import UIKit
import Alamofire

class CityWeatherDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var detailTableView: UITableView!
    
    var chosenCity : String = ""
    var chosenWoeid : Int = 0
    var weatherDetailUrl = URL(string: "https://www.metaweather.com/api/location/")!
    var weatherStateArray = [String]()
    var weatherTempArray = [Double]()
    var weatherDateArray = [String]()
    var weatherStateAbbrArray = [String]()
    
    private var loadingDetail = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = chosenCity
        getDetailData()
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
    }
    
    
    func getDetailData(){
        let url = "\(weatherDetailUrl)" + "\(chosenWoeid)"
        
        let request = AF.request(url).validate()
        request.responseJSON {(data) in
            // print(data)
        }
        
        let encodedResponse = AF.request(url)
            .responseData { (response) in
                guard let model = response.value else { return }
                let utf8Text = String(data: model, encoding: .utf8) ?? String(decoding: model, as: UTF8.self)
                // print(utf8Text)
            }
        encodedResponse.validate()
            .responseDecodable(of: CityWeatherDetailModel.self){ (response) in
                switch response.result {
                case .success(let models):
                    for model in models.consolidatedWeather {
                        
                        self.weatherStateArray.append(model.weatherStateName)
                        self.weatherDateArray.append(model.applicableDate)
                        self.weatherStateAbbrArray.append(model.weatherStateAbbr)
                        self.weatherTempArray.append(model.theTemp)
                        self.loadingDetail = true
                    }
                    print(self.weatherStateArray)
                    if self.loadingDetail {
                        DispatchQueue.main.async {
                            self.detailTableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherStateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! CityWeatherDetailCell
        if loadingDetail {
            if weatherStateArray.count > indexPath.row {
                let state = Int(weatherTempArray[indexPath.row])
                cell.setView(weatherState: weatherStateAbbrArray[indexPath.row], date: weatherDateArray[indexPath.row], temp: "\(state)", weatherDetail: weatherStateArray[indexPath.row] )
            }
        }
        return cell
    }

}
