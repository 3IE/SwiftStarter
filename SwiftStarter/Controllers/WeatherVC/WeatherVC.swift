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
    @IBOutlet weak var tableView: UITableView!
    
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.cityLabel.text = CityModel.kremlinBicetre.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: self.view, animated: true)

        Task {
            let data = await self.getData()
            
            DispatchQueue.main.async {
                guard let currentWeather = data?.0, let currentForecast = data?.1, let forecasts = currentForecast.forecasts else {
                    return
                }

                self.temperatureLabel.text = "\(currentWeather.temperature ?? 0) °C"
                self.descriptionLabel.text = currentWeather.weatherInfos?.first?.description?.capitalizingFirstLetter() ?? "Unknown weather"

                self.forecasts = forecasts
                MBProgressHUD.hide(for: self.view, animated: true)
                self.tableView.reloadData()
            }
        }
    }
    
    func getData() async -> (WeatherResponse?, ForecastResponse?)? {
        await withTaskGroup(of: (WeatherResponse?, ForecastResponse?).self, body: { task in
            task.addTask {
                return await (WeatherBusiness.getCurrentWeather(city: .kremlinBicetre), WeatherBusiness.getForecast(forCity: .kremlinBicetre))
            }
            
            return await task.next()
        })
    }
}

