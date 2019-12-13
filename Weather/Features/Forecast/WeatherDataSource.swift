//
//  WeatherDataSource.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import UIKit


class WeatherDataSource : NSObject {
     var weatherViewModel : WeatherViewModel
    
    init( weatherViewModel : WeatherViewModel) {
        self.weatherViewModel = weatherViewModel
    }
    
    func configureTableView(tableView : UITableView){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension WeatherDataSource : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModel.fiveDayForecast?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.forecastVM = weatherViewModel.fiveDayForecast?[indexPath.row]
        return cell
    }

}


extension WeatherDataSource : UITableViewDelegate{
    
}
