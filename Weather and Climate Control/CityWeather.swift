//
//  CityWeather.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import Foundation

enum Weekday {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

struct CityWeather {
    var cityName: String
    var stateName: String
    var isMorning: Bool
    var days: [DayWeather] = []
    
    func locationInfo() -> String {
        return "\(cityName), \(stateName)"
    }
}

struct DayWeather {
    var day: Weekday
    var highTemp: Double
    var lowTemp: Double
    var weatherImageName: String
}

