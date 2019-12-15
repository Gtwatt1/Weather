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
    let forecast : Forecast
    
    init(forecast : Forecast) {
        self.forecast = forecast
        temperature = "\(Int(forecast.main?.temp?.rounded() ?? 0.0) )º"
        weatherImage = getWeatherType()
        day = getDayOfTheWeek( )
    }
    
    
    func getDayOfTheWeek() -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt ?? 0))
        return date.dayOfWeek()
    }
    
    func getWeatherType() -> String{
        switch (forecast.weather?[0].main ?? "").lowercased() {
        case "rain", "thunderstorm", "drizzle", "snow", "mist":
            return "rain"
        case let str where str.contains("cloud") :
            return "clear"
        default:
            return "partlysunny"
        }
    }
    
    
}
