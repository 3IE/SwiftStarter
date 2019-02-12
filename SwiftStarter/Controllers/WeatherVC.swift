//
//  ViewController.swift
//  iOS-Starter2019
//
//  Created by Sofiane Beors on 11/02/2019.
//  Copyright © 2019 3ie. All rights reserved.
//

import SVProgressHUD

class WeatherVC: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forecastTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        self.cityLabel.text = CityModel.kremlinBicetre.name
        self.forecastTextView.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.show(withStatus: "Fetching in progress")
        
        WeatherBusiness.getCurrentWeather(forCity: .kremlinBicetre) { (response, error) in
            DispatchQueue.main.async {
                guard let response = response, error == nil else { fatalError((error?.localizedDescription)!) }
                self.temperatureLabel.text = "\(response.temperature ?? 0) °C"
                self.descriptionLabel.text = response.weatherInfos?.first?.description?.capitalizingFirstLetter() ?? "Unknown weather"
                SVProgressHUD.showSuccess(withStatus: "Done")
                SVProgressHUD.dismiss(withDelay: 1.5)
            }
        }
        
        WeatherBusiness.getForecast(forCity: .kremlinBicetre) { (response, error) in
            DispatchQueue.main.async {
                guard let response = response, error == nil else { fatalError((error?.localizedDescription)!) }
                var forecasts: [String] = []
                for forecast in response.forecasts! {
                    forecasts += (forecast.weatherInfos?.map({ (weatherInfo) in
                        return "\(forecast.hour!): \(forecast.temperature!) °C - \(weatherInfo.description!.capitalizingFirstLetter())\n"
                    }))!
                }
                self.forecastTextView.text = forecasts.joined(separator: "\n")
            }
        }
    }
}

