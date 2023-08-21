//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
   
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
      var weatherManager=WeatherManager()
    let locationManager=CLLocationManager()
    override func viewDidLoad() {
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        
        weatherManager.delegate=self
        cityLabel.delegate=self
        super.viewDidLoad()
    
    }

    
   
    
}
extension WeatherViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location=locations.last{
            locationManager.stopUpdatingLocation()
            let lat=location.coordinate.latitude
            let lon=location.coordinate.longitude
            print(lat)
            print(lon)
            weatherManager.fetchWeather(city: "lat=\(lat)&lon=\(lon)")
            
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

//MARK: - UITextFieldDelegate


extension WeatherViewController:UITextFieldDelegate{
    @IBAction func sourc(_ sender: UIButton) {
        cityLabel.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityLabel.endEditing(true)
        return true
    }
   func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
        
            
         return true
        }else{
            textField.placeholder="Type Somethig"
            return false
        }
    }
   func textFieldDidEndEditing(_ textField: UITextField) {
       
       weatherManager.fetchWeather(city: "q=\(cityLabel.text ?? "Ankara")")

    }
    @IBAction func locationUpdate(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - WeatherManagerDelegate


extension WeatherViewController:WeatherManagerDalagete{
    
    func veri(weatherManager:WeatherManager,veri: Model) {
        DispatchQueue.main.async{
            self.city.text=veri.citys
            self.temperatureLabel.text=String(veri.clodius)
            self.conditionImageView.image=UIImage(systemName: veri.ıconResult)
            print( veri.ıconResult)
            
        }
        
        
    }
    func errorDelegate(error: Error) {
    print(error)
    }
   
  
       
}



