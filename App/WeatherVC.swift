//
//  WeatherVC.swift
//  App
//
//  Created by Benoit Verdier on 10/02/2016.
//  Copyright © 2016 3IE. All rights reserved.
//

import UIKit
import SVProgressHUD

class WeatherVC: UIViewController {
	
	@IBOutlet weak var temperatureLabelOutlet: UILabel!
	@IBOutlet weak var descriptionLabelOutlet: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		SVProgressHUD.showWithStatus("Fetching in progress")
		WeatherBusiness.GetWeather(forTown: TownWithWoeid.KremlinBicetre) { (response, error) in
			dispatch_async(dispatch_get_main_queue(), {
				if (error == nil) {
					self.temperatureLabelOutlet.text = "\(response?.weatherCondition?.temperature ?? 0)"
					self.descriptionLabelOutlet.text = response?.weatherCondition?.description ?? "unknown"
					SVProgressHUD.showSuccessWithStatus("done !")
				}
				else {
					SVProgressHUD.showErrorWithStatus("failure")
				}
			})
		}
	}
	
}
