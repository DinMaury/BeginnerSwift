//
//  ViewController.swift
//  rainyshinycloudy
//  WeatherVC.swift
//
//  Created by Maury on 9/05/22.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController,UITableViewDelegate,UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentClimateImg: UIImageView!
    
    @IBOutlet weak var currentClimateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // Variables de Geolocation
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // Clases de datos descargados
    var currentWeather: CurrentWeather = CurrentWeather()
    var forecast: Forecast = Forecast()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Geolocation
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        // Delegacion de tableView
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    // MARK: - Control of tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.highTemp.count - 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            cell.configureCell(forecast: self.forecast, num: indexPath.row)
            return cell
        } else {
            return WeatherCell()
        }
    }
    //MARK: --------
    
    //MARK: Funtion to Geolocation
    func locationAuthStatus() {
            let status = locationManager.authorizationStatus
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()
            default:
                locationManager.requestAlwaysAuthorization()
                locationAuthStatus()
            }
            // Funciones asincronas
            currentWeather.downloadWeatherDetails {
                self.updateMainUIToday()
                
            }
            forecast.downloadForecastDetails {
                self.tableView.reloadData()
                
            }
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard currentLocation == nil, let currentLocation = locations.last else { return }
            
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            
            self.currentLocation = currentLocation
            
            // llamar metodo de google maps para traer la ciudad
        }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    //MARK: --------
    
    //MARK: - Actualizacion de la vista superior
    func updateMainUIToday() {
        dateLabel.text = currentWeather.dateWeather
        currentTempLabel.text = "\(Int(currentWeather.currentTemp))°C"
        locationLabel.text = currentWeather.cityName + ", " + currentWeather.countryName
        currentClimateImg.image = UIImage(named: currentWeather.weatherType)
        currentClimateLabel.text = currentWeather.weatherType
    }
    //MARK: --------
}

