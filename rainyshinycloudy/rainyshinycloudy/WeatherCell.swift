//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Maury on 12/05/22.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast, num: Int) {
        lowTemp.text = "\(forecast.lowTemp[num])°C"
        highTemp.text = "\(forecast.highTemp[num])°C"
        weatherType.text = forecast.weatherType[num]
        weatherIcon.image = UIImage(named: forecast.weatherType[num])
        dayLabel.text = forecast.dateForecast[num]
        
    }
}
