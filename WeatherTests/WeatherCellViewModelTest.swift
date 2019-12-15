//
//  WeatherCellViewModel.swift
//  WeatherTests
//
//  Created by Godwin Olorunshola on 15/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import XCTest
@testable import Weather


class WeatherCellViewModelTest: XCTestCase {

    var forecast : Forecast!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mainWeather =  Main(temp: 10.0, feelsLike: 19.0, tempMin: 9.0, tempMax: 14.6, pressure: 34, humidity: 24)
        let weather = [Weather(id: 801, main: "Rain", weatherDescription: "light rain", icon: "02n")]
         forecast = Forecast(weather: weather, main: mainWeather, dt: 1576303200, timezone: nil, id: nil, name: nil, dateString: "2019-12-19 06:00:00")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testGetWeatherType(){
        let cellViewModel = WeatherCellViewModel(forecast: forecast)

        let weatherType = cellViewModel.getWeatherType()
        XCTAssertEqual("rain", weatherType)
    }

    func testGetDayOftheWeek(){
        
        let date = Date(timeIntervalSince1970: TimeInterval(forecast?.dt ?? 0))
        XCTAssertEqual("Saturday", date.dayOfWeek())

    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
