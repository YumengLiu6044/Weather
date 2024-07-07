//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Yumeng Liu on 7/7/24.
//

import Foundation

// Model of the response body we get from calling the API

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Int
    let current_units: CurrentUnits
    let current: Current
    let hourly_units: HourlyUnits
    let hourly: Hourly
    let daily_units: DailyUnits
    let daily: Daily

    struct CurrentUnits: Codable {
        let time: String
        let interval: String
        let temperature_2m: String
        let is_day: String
        let weather_code: String
    }

    struct Current: Codable {
        let time: Date
        let interval: Int
        let temperature_2m: Float
        let is_day: Int
        let weather_code: Int
    }

    struct HourlyUnits: Codable {
        let time: String
        let temperature_2m: String
        let weather_code: String
    }

    struct Hourly: Codable {
        let time: [Date]
        let temperature_2m: [Float]
        let weather_code: [Int]
    }

    struct DailyUnits: Codable {
        let time: String
        let weather_code: String
        let temperature_2m_max: String
        let temperature_2m_min: String
    }

    struct Daily: Codable {
        let time: [Date]
        let weather_code: [Int]
        let temperature_2m_max: [Double]
        let temperature_2m_min: [Double]
        let sunset: [Date]
        let sunrise: [Date]
    }
}


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
