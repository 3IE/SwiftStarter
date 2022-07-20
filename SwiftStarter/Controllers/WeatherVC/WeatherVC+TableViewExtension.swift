//
//  WeatherVC+TableViewExtension.swift
//  SwiftStarter
//
//  Created by Sofiane Beors on 11/07/2022.
//  Copyright © 2022 3ie. All rights reserved.
//

import UIKit

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath)
        
        guard let date = forecasts[indexPath.row].date, let temperature = forecasts[indexPath.row].temperature, let infos = forecasts[indexPath.row].weatherInfos else { return cell }
        
        cell.textLabel?.text = "\(temperature)°C"
        cell.detailTextLabel?.text = "\(date.toDateAndHourStr()) - \(infos.map { $0.description?.capitalizingFirstLetter() ?? "" }.joined(separator: "\n"))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Forecast"
    }
}

extension String {
    func toDateAndHourStr() -> Self {
        return "\(self.components(separatedBy: ":")[0]):\(components(separatedBy: ":")[1])"
    }
}
