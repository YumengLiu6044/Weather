//
//  CurrentWeatherView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/3/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    var currentWeather = CurrentWeather(dayName: "Wednesday", date: "Jul 3", temperature: 36, temperatureUnit: "°C", weatherName: "Sunny", weatherIconName: "https://openweathermap.org/img/wn/01d@2x.png")
    @State private var isLoading = true
    @State private var currentTime = "23:59"
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack{
                VStack{
                    AsyncImage(url: URL(string: currentWeather.weatherIconName), transaction: Transaction(animation: .spring(response: 1, dampingFraction: 0.6, blendDuration: 0.5))) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
                                .shadow(radius: 10)
                                .onAppear {
                                    isLoading = false
                                }
                            
                        case .failure:
                            Image(systemName: "questionmark.app")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60)
                                .onAppear {
                                    isLoading = false
                                }
                            
                        case .empty:
                            ProgressView()
                                .frame(width: 60)
                                .onAppear {
                                    isLoading = true
                                }
                            
                        @unknown default:
                            EmptyView()
                                .onAppear {
                                    isLoading = false
                                }
                        }}
                    .padding([.top, .bottom, .trailing], 3.0)
                    
                    HStack {
                        Text(currentWeather.weatherName)
                        Text(currentWeather.presentTemperature())
                    }
                        .font(.title2)
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                }
                .padding()
                .background()
                .backgroundStyle(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 10))
                Spacer()
                VStack(alignment: .trailing){
                    Text(currentTime)
                        .onReceive(timer) { _ in
                            self.currentTime = getHourAndMinute(from: Date())
                        }
                    
                    Text(currentWeather.dayName)
                    Text(currentWeather.date)
                }
                .font(.system(size: 35))
                .frame(alignment: .trailing)
            }
                
            
        }
        .redacted(reason: isLoading ? .placeholder : [])
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
    let weatherName: String
    let weatherIconName: String
    
    func presentTemperature() -> String {
        return "\(temperature) \(temperatureUnit)"
    }
}

#Preview {
    CurrentWeatherView()
}
