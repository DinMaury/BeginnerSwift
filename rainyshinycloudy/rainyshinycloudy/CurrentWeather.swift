//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Maury on 10/05/22.
//

import UIKit
import Alamofire

class CurrentWeather {
    private(set) var cityName: String! = ""
    private(set) var countryName: String! = ""
    private(set) var dateWeather: String! = ""
    private(set) var weatherType: String! = ""
    private(set) var currentTemp: Double! = 0.0
    
    
    init() {
        if dateWeather == nil {
            dateWeather = ""
        }
        let dateFormartter = DateFormatter()
        dateFormartter.dateStyle = .medium
        dateFormartter.timeStyle = .none
        let currentDate = dateFormartter.string(from: Date())
        self.dateWeather = "Today, \(currentDate)"
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Alamofire download
        AF.request(currentWeatherURL).responseJSON { response in
            if let dict = response.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self.cityName = name.capitalized
                }
                if let weather = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let country = weather["country"] as? String {
                        self.countryName = country.capitalized
                    }
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let description = weather[0]["main"] as? String {
                        self.weatherType = description.capitalized
                    }
                }
                if let temperature = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = temperature["temp_min"] as? Double {
                        self.currentTemp = (temp - 273.15).rounded() // from Kelvin to Celsius
                    }
                }
            }
            completed()
        }
    }
}
