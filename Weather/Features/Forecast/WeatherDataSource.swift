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
        print(weatherViewModel.fiveDayForecast?[indexPath.row])
        cell.forecastVM = weatherViewModel.fiveDayForecast?[indexPath.row]
        return cell
    }

}


extension WeatherDataSource : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)

        UIView.animate(
            withDuration: 0.5,
            delay: 0.5 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
}
