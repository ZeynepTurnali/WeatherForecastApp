//
//  ViewController.swift
//  AppcentWeatherApp

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController {
    
    let weatherUrl = URL(string: "https://www.metaweather.com/api/location/search/?query=istanbul")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func getData(){
        
        let request = AF.request(weatherUrl).validate()
        request.responseJSON {(data) in
            //  print(data)
        }
        
        let encodedResponse = AF.request(weatherUrl)
            .responseData { (response) in
                guard let model = response.value else { return }
                let utf8Text = String(data: model, encoding: .utf8) ?? String(decoding: model, as: UTF8.self)
              //  print(utf8Text)
            }
        
        encodedResponse.validate()
            .responseDecodable(of: [WeatherDataModel].self){ (response) in
                switch response.result {
                case .success(let model):
                    print(model.first!.title)
//                  guard let model = response.value else { return }
//                  print(model.first!.title)
                    
                case .failure(let error):
                    print(error)
                }
                
                
            }
        
    }
    
    
    
}

