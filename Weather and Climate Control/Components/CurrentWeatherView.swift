//
//  CurrentWeatherView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/3/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    var currentWeather = SampleData.sampleCurrentWeather
    
    @State private var isLoading    = true
    @State private var currentTime  = "23:59"
    @State private var timer        = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack{
                VStack{
                    OnlineImageView(imageURL: currentWeather.weatherIconName, isLoading: $isLoading)
                        .frame(width: 50)
                    .padding([.top, .bottom, .trailing], 3.0)
                    
                    HStack {
                        Text(currentWeather.weatherName)
                        Text(currentWeather.presentTemperature())
                    }
                    .shimmering(active: isLoading)
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
                .shimmering(active: isLoading)
            }
                
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .font(.system(size: 40))
        .foregroundStyle(.white)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}



#Preview {
    CurrentWeatherView()
}
