//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Maury on 10/05/22.
//

import Foundation

typealias DownloadComplete = ()-> ()

// https://openweathermap.org/

let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
let lat = "lat="
let lon = "&lon="
let appID = "&appid="
let apiKey = "42a1771a0b787bf12e734ada0cfc80cb"

let currentWeatherURL = "\(baseURL)\(lat)\(Location.sharedInstance.latitude ?? 0.0)\(lon)\(Location.sharedInstance.longitude ?? 0.0)\(appID)\(apiKey)"

let baseDaysURL = "https://api.openweathermap.org/data/2.5/forecast/daily?"
let unitsDays = "&units=metric"
let countDays = "&cnt=10"

let currentForecastURL = "\(baseDaysURL)\(lat)\(Location.sharedInstance.latitude ?? 0.0)\(lon)\(Location.sharedInstance.longitude ?? 0.0)\(unitsDays)\(countDays)\(appID)\(apiKey)"




