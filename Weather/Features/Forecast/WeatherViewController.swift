//
//  ViewController.swift
//  Weather
//
//  Created by Godwin Olorunshola on 11/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var weatherViewModel : WeatherViewModel?
    var weatherDataSource : WeatherDataSource?
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var cityLabel : UILabel!

    @IBOutlet weak var minTemperatureLabel : UILabel!
    @IBOutlet weak var maxTemperatureLabel : UILabel!
    @IBOutlet weak var currentTemperatureLabel : UILabel!
    @IBOutlet weak var moreCurrentDayTemperatureDetailsLabel : UIStackView!


    @IBOutlet weak var weatherDescriptionLabel : UILabel!
    @IBOutlet weak var weatherImage : UIImageView!


    
    @IBAction func changeTheme(_ sender : UIButton){
        print("mad oh")
        weatherViewModel?.changeTheme()
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherViewModel = WeatherViewModel()
        if let weatherViewModel = weatherViewModel{
            weatherDataSource = WeatherDataSource(weatherViewModel : weatherViewModel)
            weatherDataSource?.configureTableView(tableView : tableView)
            weatherViewModel.requestLocationService()
            weatherViewModel.didUpdateCurrentForecast = { [weak self] in
                DispatchQueue.main.async{
                    self?.cityLabel.text = weatherViewModel.currentDayForecast?.name
                    self?.weatherDescriptionLabel.text = weatherViewModel.currentDayForecast?.weather?[0].weatherDescription?.capitalized
                    self?.temperatureLabel.text = "\( weatherViewModel.currentDayForecast?.main?.temp ?? 0)º"
                    self?.minTemperatureLabel.text = "\( weatherViewModel.currentDayForecast?.main?.tempMin ?? 0)º"
                    self?.maxTemperatureLabel.text = "\( weatherViewModel.currentDayForecast?.main?.tempMax ?? 0)º"
                    self?.currentTemperatureLabel.text = "\( weatherViewModel.currentDayForecast?.main?.temp ?? 0)º"
                    self?.weatherImage.image = UIImage(named : weatherViewModel.weatherImage)
                    let backgroundColor = UIColor.hexStringToUIColor(hex: weatherViewModel.backgroundColor)
                    self?.tableView.backgroundColor = backgroundColor
        self?.moreCurrentDayTemperatureDetailsLabel.addBackground(color : backgroundColor)
                }
                
            }
            weatherViewModel.didUpdateFiveDaysForecast = {[weak self] in
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            }
            
            weatherViewModel.didChangeTheme = {[weak self] in
                print(weatherViewModel.weatherImage)
                 self?.weatherImage.image = UIImage(named : weatherViewModel.weatherImage)
            }
        }
        
        
    }
    
   


}

