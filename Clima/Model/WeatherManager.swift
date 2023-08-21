//
//  WeatherManager.swift
//  Clima
//
//  Created by Muhammet Emre Kemancı on 18.08.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDalagete{
    func veri(weatherManager:WeatherManager,veri:Model)
    func errorDelegate(error:Error)
}
struct WeatherManager{
    var delegate:WeatherManagerDalagete?
    
        func fetchWeather(city:String){
    let weatherUrl="https://api.openweathermap.org/data/2.5/weather?\(city)&units=metric&appid=Your API#"
           
     weatherReturnJson(urlString: weatherUrl)
        
    }
    
    func weatherReturnJson(urlString:String){
        if let url = URL(string: urlString){
            let sesion=URLSession(configuration: .default)
            let task = sesion.dataTask(with: url) { data, urlRespons, error in
                if (error != nil){
                    print(error!)
                    self.delegate?.errorDelegate(error: error!)
                    return
                }
                if let safeData=data{
                    if let weatherr = self.parseJson(data: safeData){
                        self.delegate?.veri(weatherManager: self,veri: weatherr)
                       
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
    func parseJson(data:Data)->Model?{
        let decoder=JSONDecoder()
        do{
            let veri = try decoder.decode(WeatherModel.self, from:data)
            let nameCity=veri.name
            let temp=veri.main.temp
            let weather=veri.weather[0].icon
            let mode=Model(weathers: weather, clodius: Int(temp), citys: nameCity)
            return mode
        }catch{
            self.delegate?.errorDelegate(error: error)
            return nil
        }
        
    }
   
    }

