//
//  ViewController.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 11/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import MBProgressHUD

class WeatherVC: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forecastTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityLabel.text = CityModel.kremlinBicetre.name
        self.forecastTextView.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Task {
            let currentWeather = await WeatherBusiness.getCurrentWeather(city: .kremlinBicetre)
            let forecast = await WeatherBusiness.getForecast(forCity: .kremlinBicetre)
            
            DispatchQueue.main.async {
                guard let currentWeather = currentWeather, let forecast = forecast else { return }

                self.temperatureLabel.text = "\(currentWeather.temperature ?? 0) °C"
                self.descriptionLabel.text = currentWeather.weatherInfos?.first?.description?.capitalizingFirstLetter() ?? "Unknown weather"

                var forecasts: [String] = []
                for forecast in forecast.forecasts! {
                    forecasts += (forecast.weatherInfos?.map({ (weatherInfo) in
                        return "\(forecast.hour!): \(forecast.temperature!) °C - \(weatherInfo.description!.capitalizingFirstLetter())\n"
                    }))!
                }
                self.forecastTextView.text = forecasts.joined(separator: "\n")
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}

