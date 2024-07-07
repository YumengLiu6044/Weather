//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Yumeng Liu on 7/7/24.
//

import Foundation

struct CurrentWeather {
    let dayName: String
    let date: String
    let temperature: Float
    let temperatureUnit: String
    let weatherName: String
    let weatherIconName: String
    
    func presentTemperature() -> String {
        return "\(temperature)°"
    }
}

struct HourWeatherItem : Identifiable {
    let id: UUID = UUID()
    let hour: String
    let weatherIconName: String
    let temperature: Float
    let temperatureUnit: String
    
    func presentTemperature() -> String {
        return "\(temperature)°"
    }
    
}

struct DayWeatherItem: Identifiable {
    let id: UUID = UUID()
    let dayName: String
    let maxTemperature: Double
    let minTemperature: Double
    let temperatureUnit: String
    let weatherIconName: String
    
}
