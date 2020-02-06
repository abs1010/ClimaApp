//
//  dataProvider.swift
//  Clima
//
//  Created by Alan Silva on 05/02/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//protocol WeatherControllerDelegate : class {
//    func getTheWeatherSuccessfully(weatherData: WeatherDataModel)
//    func didNotGetTheWeatherData(error: Error)
//}


let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
let APP_ID = "d909fb10b54074b50c128e3cbead106e"

class WeatherController {
    
    let weatherDataModel = WeatherDataModel()
    
    //weak var delegate = WeatherControllerDelegate?
    
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }
    
    func updateWeatherData(json : JSON) {
    
        let tempResult = json["main"]["temp"].doubleValue
    
            weatherDataModel.temperature = Int(tempResult - 273.15)
    
            weatherDataModel.city = json["name"].stringValue
    
            weatherDataModel.condition = json["weather"][0]["id"].intValue
    
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
    
            updateUIWithWeatherData()
        }
    
}
