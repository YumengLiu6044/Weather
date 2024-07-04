//
//  ContentView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    var weatherManager = WeatherManager()
    var location: CLLocationCoordinate2D

    @State private var response: WeatherData?
    @State private var cityName: String = "Your location"
    @State private var hourWeatherArray: [HourWeatherItem] = [
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
    @State private var dayWeatherArray: [DayWeatherItem] = [
        DayWeatherItem(dayName: "Today", maxTemperature: 42, minTemperature: 18, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Thursday", maxTemperature: 41, minTemperature: 17, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Friday", maxTemperature: 38, minTemperature: 16, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Saturday", maxTemperature: 35, minTemperature: 12, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Sunday", maxTemperature: 33, minTemperature: 14, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Monday", maxTemperature: 30, minTemperature: 12, temperatureUnit: "°C", weatherIconName: ""),
        DayWeatherItem(dayName: "Tuesday", maxTemperature: 32, minTemperature: 13, temperatureUnit: "°C", weatherIconName: "")
    ]
    @State private var currentWeather: CurrentWeather = CurrentWeather(dayName: "Wednesday", date: "Jul 3", temperature: 36, temperatureUnit: "°C", weatherName: "Sunny", weatherIconName: "https://openweathermap.org/img/wn/01d@2x.png")
    
    @State private var isVisible = false
    @State private var isLoading = true
    @State private var isDay = true
    
    var body: some View {
        ZStack {
            AnimatedLinearGradient(isDay: $isDay)
                .ignoresSafeArea()
            
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
                        VStack(spacing: 10) {
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
        .redacted(reason: isLoading ? .placeholder : [])
        .onAppear {
            withAnimation {
                isVisible = true
            }
        }
        .task {
            do {
                response = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                
            } catch networkingError.responseError {
                print("Response Error")
            } catch networkingError.dataError {
                print("Data error")
            } catch {
                print("Unexpected error")
            }
            if let response = response {
                currentWeather = loadCurrentWeather(response)
                hourWeatherArray = loadHourWeather(response)
                dayWeatherArray = loadDailyWeather(response)
            }
            isLoading = false
            if let response = response {
                isDay = (isDayTime(date: Date(), response: response) == 1)
            }
        }
    }
}

struct AnimatedLinearGradient: View {
    @Binding var isDay: Bool

    var body: some View {
        LinearGradient(colors: [isDay ? .blue : .black, isDay ? .blue.opacity(0.5) : .black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
            .animation(.easeInOut(duration: 1), value: isDay)
    }
}

//#Preview {
//    let loc = CLLocationCoordinate2D(latitude: 37, longitude: -121)
//    WeatherView(location: loc)
//}
