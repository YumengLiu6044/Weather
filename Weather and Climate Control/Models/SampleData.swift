//
//  SampleData.swift
//  Weather
//
//  Created by Yumeng Liu on 7/7/24.
//

import Foundation

struct SampleData {
    static let sampleHourWeatherArray = [
        HourWeatherItem(hour: "Now", weatherIconName: "", temperature: 32, temperatureUnit: "°C"),
        HourWeatherItem(hour: "10AM", weatherIconName: "", temperature: 36, temperatureUnit: "°C"),
        HourWeatherItem(hour: "11AM", weatherIconName: "", temperature: 38, temperatureUnit: "°C"),
        HourWeatherItem(hour: "12AM", weatherIconName: "", temperature: 39, temperatureUnit: "°C"),
        HourWeatherItem(hour: "1PM", weatherIconName: "", temperature: 40, temperatureUnit: "°C"),
        HourWeatherItem(hour: "2PM", weatherIconName: "", temperature: 41, temperatureUnit: "°C"),
        HourWeatherItem(hour: "3PM", weatherIconName: "", temperature: 41, temperatureUnit: "°C"),
        HourWeatherItem(hour: "4PM", weatherIconName: "", temperature: 38, temperatureUnit: "°C"),
        HourWeatherItem(hour: "5PM", weatherIconName: "", temperature: 38, temperatureUnit: "°C")
    ]
    
    static let sampleDayWeatherArray = [
        DayWeatherItem(dayName: "Today", maxTemperature: 42, minTemperature: 18, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Thursday", maxTemperature: 41, minTemperature: 17, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Friday", maxTemperature: 38, minTemperature: 16, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Saturday", maxTemperature: 35, minTemperature: 12, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Sunday", maxTemperature: 33, minTemperature: 14, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Monday", maxTemperature: 30, minTemperature: 12, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Tuesday", maxTemperature: 32, minTemperature: 13, temperatureUnit: "°C", weatherIconName: "")
    ]
    
    static let sampleCurrentWeather = CurrentWeather(dayName: "Wednesday", date: "Jul 3", temperature: 36, temperatureUnit: "°C", weatherName: "Sunny", weatherIconName: "https://openweathermap.org/img/wn/01d@2x.png")
}

