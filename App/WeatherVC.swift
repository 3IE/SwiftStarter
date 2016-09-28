//
//  WeatherVC.swift
//  App
//
//  Created by Benoit Verdier on 10/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import UIKit
import SVProgressHUD

private let kTownToUse = TownWithWoeid.paris

class WeatherVC: UIViewController {
	
	@IBOutlet weak var temperatureLabelOutlet: UILabel!
	@IBOutlet weak var descriptionLabelOutlet: UILabel!
	@IBOutlet weak var townLabelOutlet: UILabel!
	@IBOutlet weak var forecastTextViewOutlet: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
		self.townLabelOutlet.text = kTownToUse.name
		self.forecastTextViewOutlet.text = ""
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		SVProgressHUD.show(withStatus: "Fetching in progress")
		
		WeatherBusiness.GetWeather(forTown: kTownToUse) { (response, error) in
			DispatchQueue.main.async(execute: {
				if (error == nil) {
					self.temperatureLabelOutlet.text = "\(response?.weatherCondition?.temperature ?? 0) °C"
					self.descriptionLabelOutlet.text = response?.weatherCondition?.description ?? "unknown"
					SVProgressHUD.showSuccess(withStatus: "done !")
				}
				else {
					SVProgressHUD.showError(withStatus: "failure")
				}
			})
		}
		
		WeatherData.GetForecast(forTown: kTownToUse) { (response, error) in
			DispatchQueue.main.async(execute: {
				if (error == nil) {
					let forecastArray = response?.forecasts?.map({ (forecast) -> String in
						guard let date = forecast.date, let low = forecast.lowTemperature, let high = forecast.highTemperature else {
							return "";
						}
						return "\(date), temp = \(low) - \(high)"
					})
					self.forecastTextViewOutlet.text = forecastArray?.joined(separator: "\n")
				}
				else {
				}
			})
		}
	}
	
}
