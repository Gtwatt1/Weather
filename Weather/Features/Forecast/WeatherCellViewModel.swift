//
//  WeatherCellViewModel.swift
//  Weather
//
//  Created by Godwin Olorunshola on 13/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation


struct WeatherCellViewModel{
    
    var weatherImage = ""
    var temperature : String
    var day = ""
    
    init(forecast : Forecast) {
        temperature = "\(forecast.main?.temp ?? 0)º"
        weatherImage = getWeatherType(weatherMain: forecast.weather?[0].main ?? "")
        day = getDayOfTheWeek(unixTime: forecast.dt ?? 0)
    }
    
    
    func getDayOfTheWeek(unixTime : Int) -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        return date.dayOfWeek()
    }
    
    func getWeatherType(weatherMain : String) -> String{
        switch weatherMain {
        case "rain", "thunderstorm", "drizzle", "snow", "mist":
            return "rain"
        case let str where str.contains("cloud") :
            return "clear"
        default:
            return "partlysunny"
        }
    }
    
    
}
