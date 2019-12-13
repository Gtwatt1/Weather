//
//  WeatherCell.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import UIKit


class WeatherCell : UITableViewCell{
    @IBOutlet weak var dayLabel : UILabel!
    @IBOutlet weak var weatherTypeImage : UIImageView!
    @IBOutlet weak var currentTempLabel : UILabel!

    var forecastVM : WeatherCellViewModel?{
        didSet{
            if let forecastVM = forecastVM{
                currentTempLabel.text = forecastVM.temperature
                dayLabel.text = forecastVM.day
                weatherTypeImage.image = UIImage(named : forecastVM.weatherImage)
            }
            
        }
    }
    
}
