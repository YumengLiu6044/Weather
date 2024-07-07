//
//  ContentView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import SwiftUI
import CoreLocation
import Shimmer


struct WeatherView: View {
    
    var weatherManager = WeatherManager()
    
    var location: CLLocationCoordinate2D?
    var unitPreference: String
    
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var response: WeatherData?
    @State private var cityName: String     =   ""
    
    @State private var hourWeatherArray     =   SampleData.sampleHourWeatherArray
    @State private var dayWeatherArray      =   SampleData.sampleDayWeatherArray
    @State private var currentWeather       =   SampleData.sampleCurrentWeather
    
    @State private var isVisible            =   false
    @State private var isLoading            =   true
    @State private var isDay                =   true
    
    var body: some View {
        ZStack {
            AnimatedLinearGradient(isDay: $isDay)
                .ignoresSafeArea()
            
            if isVisible {
                VStack(spacing: 20) {
                    Text(cityName)
                        .font(.system(size: 50))
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.3)
                        .foregroundStyle(Color(.white))
                        .shadow(radius: 10)
                        .transition(.blurReplace())
                        .animation(.easeIn, value: cityName)
                        
                    
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
                    
                    
                    ScrollView(.vertical) {
                        VStack(spacing: 25) {
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
                        .padding(.vertical, 10)
                        .scrollTargetLayout()
                        
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    
                }
                .padding(20.0)
                .transition(.backslide)
            }
            
            
        }
        .onAppear {
            withAnimation {
                isVisible = true
            }
        }
        .task {
            await loadWeather()
        }
    }
    
    private func loadWeather() async {
        while locationManager.isLoading {
            
        }
        guard let location = locationManager.location else {return}
        do {
            response = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude, unit: unitPreference)
            
        } catch networkingError.responseError{
            print("Response Error")
        } catch networkingError.dataError {
            print("Data error")
        } catch {
            print("Unexpected error")
        }
        if let response = response{
            currentWeather = loadCurrentWeather(response)
            hourWeatherArray = loadHourWeather(response)
            dayWeatherArray = loadDailyWeather(response)
        }
        
        if let response = response {
            isDay = (isDayTime(date: Date(), response: response) == 1)
        }
        
        locationManager.lookUpCurrentLocation {
            placemark in
            if let placemark = placemark {
                // Access placemark information like locality (city), administrativeArea (state), etc.
                if let locality = placemark.locality, let administrativeArea = placemark.administrativeArea {
                    cityName = "\(locality), \(administrativeArea)"
                }
            }
        }
        isLoading = false
        
    }
    
}

