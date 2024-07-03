//
//  ContentView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import SwiftUI
import OpenMeteoSdk

struct WeatherView: View {
    var response: WeatherData
    var cityName: String = "Your location"
    @State var hourWeatherArray: [HourWeatherItem] = [
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
    var dayWeatherArray: [DayWeatherItem] = [
        DayWeatherItem(dayName: "Today", maxTemperature: 42, minTemperature: 18, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Thursday", maxTemperature: 41, minTemperature: 17, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Friday", maxTemperature: 38, minTemperature: 16, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Saturday", maxTemperature: 35, minTemperature: 12, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Sunday", maxTemperature: 33, minTemperature: 14, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Monday", maxTemperature: 30, minTemperature: 12, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Tuesday", maxTemperature: 32, minTemperature: 13, temperatureUnit: "°C", weatherIconName: "")
    ]
    @State var currentWeather: CurrentWeather = CurrentWeather(dayName: "Wednesday", date: "Jul 3", temperature: 36, temperatureUnit: "°C", weatherIconName: "http://openweathermap.org/img/wn/01d@2x.png")
    
    @State private var isVisible = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(1)], startPoint: .top, endPoint: .bottom))
                .background(Color(hue: 0.1, saturation: 0.1, brightness: 0))
            
            if isVisible {
                VStack(spacing: 20) {
                    
                    
                    Text(cityName)
                        .font(.system(size: 50))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.white))
                        .shadow(radius: 10)
                        .transition(.slide)
                    
                    CurrentWeatherView(currentWeather: currentWeather)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 5){
                            ForEach(hourWeatherArray) { day in
                                HourRowItemView(hourWeatherItem: day)
                                    .scrollTransition {
                                        content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1 : 0)
                                    }
                                
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    .transition(.slide)
                    
                    ScrollView(.vertical) {
                        VStack(spacing: 15) {
                            ForEach(dayWeatherArray) {
                                day in
                                DayWeatherRowView(dayWeatherItem: day)
                                    .scrollTransition {
                                        content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1 : 0)
                                    }
                            }
                        }
                        .scrollTargetLayout()
                        
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    .transition(.slide)
                }
                .padding(20.0)
                .transition(.blurReplace)
            }
            
        }
        .onAppear {
            withAnimation {
                isVisible = true
            }
            currentWeather = loadCurrentWeather(response)
            hourWeatherArray = loadHourWeather(response)
        }
        
    }
    
}


//#Preview {
//    WeatherView()
//}
