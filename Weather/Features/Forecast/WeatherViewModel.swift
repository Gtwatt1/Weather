//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Godwin Olorunshola on 11/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation
import CoreLocation


class WeatherViewModel{
    
    var locationService : LocationService
    var weatherService : WeatherServiceProtocol
    var userDefaultService : UserDefaultsProtocol

    
    var currentDayForecast : Forecast?
    var fiveDayForecast : [WeatherCellViewModel]?
    var error = ""
    var didUpdateCurrentForecast : (() -> ())?
    var didUpdateFiveDaysForecast : (() -> ())?
    var didUpdateWithError : (() -> ())?
    var didChangeTheme : (() -> ())?

    fileprivate func setBackgroundView() {
        switch weatherType {
        case .cloudy:
            weatherImage = theme == Theme.forest ? "forest_cloudy" : "sea_cloudy"
            backgroundColor = "54717A"
        case .rainy:
            weatherImage = theme == Theme.forest ? "forest_rainy" : "sea_rainy"
            backgroundColor = "57575D"
        case .sunny:
            weatherImage = theme == Theme.forest ? "forest_sunny" : "sea_sunny"
            backgroundColor = "47AB2F"
        }
    }
    
    var weatherType = WeatherType.cloudy{
        didSet{
            setBackgroundView()
        }
    }
    var theme : Theme?{
        didSet{
            if let theme = theme{
                userDefaultService.setTheme(value: theme)
                setBackgroundView()
            }
            didChangeTheme?()

        }
    }
    var backgroundColor = ""
    var weatherImage = ""

    
    init() {
        locationService = LocationService()
        weatherService = WeatherService()
        userDefaultService = UserDefaultService()
        theme = userDefaultService.getTheme()
        fiveDayForecast = [WeatherCellViewModel]()
        requestLocationService()
    }
    
    
    func requestLocationService(){
        locationService.delegate = self
        locationService.startLocationRequest()
    }
    
    func changeTheme(){
        if let theme = theme{
            if  theme == .forest{
                self.theme = .sea
            }else{
                self.theme = .forest
            }
        }
    }
    
}


extension WeatherViewModel : LocationServiceDelegate{
    func didGetLocation(_ lat: CLLocationDegrees, lng: CLLocationDegrees) {
        weatherService.getCurrentDayWeather(lat: lat, lng: lng) {[weak self] (result: Result<Forecast , APIError> ) in
            switch result{
                case .success(let forecast) :
                    self?.currentDayForecast = forecast
                    let weatherMain = forecast.weather?[0].main?.lowercased()
                    switch weatherMain {
                    case "rain", "thunderstorm", "drizzle", "snow", "mist":
                        self?.weatherType = WeatherType.rainy
                    case let str where str?.contains("cloud") ?? false:
                        self?.weatherType = WeatherType.cloudy
                    default:
                        self?.weatherType = WeatherType.sunny
                    }
                    self?.didUpdateCurrentForecast?()
                case .failure(let error) :
                print("")

            }
            
        }
        
        weatherService.getFivedaysWeather(lat: lat, lng: lat) { [weak self] (result: Result<ForecastList , APIError> )  in
            switch result{
                case .success(let forecasts) :
                    let forecastsAtMidday = forecasts.list.filter { (forecast) -> Bool in
                    (forecast.dateString?.contains("12:00:00") ?? false)
                }
                 self?.fiveDayForecast?.removeAll()
                 forecastsAtMidday.forEach { (forecast) in
                    let weatherCellViewModel =  WeatherCellViewModel(forecast: forecast)
                    self?.fiveDayForecast?.append(weatherCellViewModel)
                }
                    self?.didUpdateFiveDaysForecast?()
                case .failure(let error) :
                print("")

            }
        }
        
    }
    
    func locationdidFail(_ reason: String) {
        error = reason
    }
    
    
}
