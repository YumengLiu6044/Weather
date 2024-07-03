//
//  CurrentWeatherView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/3/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    var currentWeather = CurrentWeather(dayName: "Wednesday", date: "Jul 3", temperature: 36, temperatureUnit: "°C", weatherIconName: "http://openweathermap.org/img/wn/01d@2x.png")
    var body: some View {
        VStack {
            HStack{
                VStack{
                    AsyncImage(url: URL(string: currentWeather.weatherIconName), transaction: Transaction(animation: .spring(response: 1, dampingFraction: 0.6, blendDuration: 0.5))) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                            
                        case .failure:
                            Image(systemName: "questionmark.app")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                            
                        case .empty:
                            ProgressView()
                                .padding(.bottom, 5)
                            
                        @unknown default:
                            EmptyView()
                        }}
                    
                    Text(currentWeather.presentTemperature())
                }
                Spacer()
                VStack{
                    Text(currentWeather.dayName + "\n" + currentWeather.date)
                    
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
                .multilineTextAlignment(.trailing)
            }
                
            
        }
        .font(.system(size: 40))
        .foregroundStyle(.white)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct CurrentWeather {
    let dayName: String
    let date: String
    let temperature: Float
    let temperatureUnit: String
    let weatherIconName: String
    
    func presentTemperature() -> String {
        return "\(temperature) \(temperatureUnit)"
    }
}

#Preview {
    CurrentWeatherView()
}
