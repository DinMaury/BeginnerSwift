//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Maury on 11/05/22.
//

import UIKit
import Alamofire

class Forecast {
    var countForecast: Int! = 10
    private(set) var dateForecast: [String]! = [String]()
    private(set) var weatherType: [String]! = [String]()
    private(set) var highTemp: [Double]! = [Double]()
    private(set) var lowTemp: [Double]! = [Double]()
    
    func downloadForecastDetails(completed: @escaping DownloadComplete) {
        //Alamofire download
        
        AF.request(currentForecastURL).responseJSON { response in
            for i in 1..<self.countForecast {
                if let dict = response.value as? Dictionary<String, AnyObject> {
                    if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                        if let dt = list[i]["dt"] as? Double {
                            let unixConverDate = Date(timeIntervalSince1970: dt)
                            self.dateForecast.append(unixConverDate.dayOfTheWeek())
                        }
                        if list[i]["weather"] != nil {
                            if let weather = list[i]["weather"] as? [Dictionary<String, AnyObject>] {
                                if let description = weather[0]["main"] as? String {
                                    self.weatherType.append(description.capitalized)
                                }
                            }
                            if let temp = list[i]["temp"] as? Dictionary<String, AnyObject> {
                                if let maxDays = temp["max"] as? Double {
                                    self.highTemp.append(maxDays)
                                }
                                if let minDays = temp["min"] as? Double {
                                    self.lowTemp.append(minDays)
                                }
                            }
                        }
                    }
                }
                
            }
            
            completed()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
