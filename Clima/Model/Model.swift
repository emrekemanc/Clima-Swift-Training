//
//  Model.swift
//  Clima
//
//  Created by Muhammet Emre Kemancı on 19.08.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


struct Model{
    var weathers:String
    var clodius:Int
    var citys:String
   
   
    var ıconResult: String{
        
        switch weathers{
        case "01d":
            // clear sky
            return "sun.min.fill"
        case "02d":
            //few clouds
            return "cloud.sun.fill"
            
        case "03d":
            //scattered clouds
            return " cloud.fill"
            
        case "04d":
            //broken clouds
            return " cloud.fill"
            
        case "09d":
            //shower rain
            return "cloud.snow.fill"
            
        case "10d":
            //rain
            return "cloud.sun.rain.fill"
            
        case "11d":
            //thunderstorm
            return "cloud.bolt.fill"
            
        case "13d":
            //snow
            return "snowflake.circle.fill"
            
        case "50d":
            //mist
            return "cloud.fog.fill"
            
        default :
            return "sun.min"
        }
        
        
    }}
