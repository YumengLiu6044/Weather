//
//  DayWeatherRowView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/3/24.
//

import SwiftUI
import Shimmer

struct DayWeatherRowView: View {
    var dayWeatherItem: DayWeatherItem = SampleData.sampleDayWeatherArray[0]
    
    @State private var maxTemperature: Double = 42
    @State private var minTemperature: Double = 10
    
    @State private var isLoading = true
    
    var body: some View {
        HStack {
            OnlineImageView(imageURL: dayWeatherItem.weatherIconName, isLoading: $isLoading)
                .frame(width:45)
            
            .padding(.trailing, 10.0)
            
            Text(dayWeatherItem.dayName)
                .shimmering(active: isLoading)
            
            Spacer()
            
            GaugeRow(gaugeData: GaugeData(minimunValue: self.minTemperature, maximimValue: self.maxTemperature, minimunTrackValue: dayWeatherItem.minTemperature, maximimTrackValue: dayWeatherItem.maxTemperature))
                .frame(width: 200, height: 10)
                .shimmering(active: isLoading)
                
                
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .font(.title2)
        .foregroundStyle(.white)
        .shadow(radius: 10)
        .listRowSeparator(.hidden)
        .listRowBackground(Rectangle().foregroundStyle(.ultraThinMaterial))
        .padding(.horizontal, 10.0)
        .onAppear {
            maxTemperature = (dayWeatherItem.temperatureUnit == "°C") ? 42 : 100
            minTemperature = (dayWeatherItem.temperatureUnit == "°C") ? 11 : 50
        }
    }
    
}



#Preview {
    ZStack {
        Rectangle()
            .foregroundStyle(.gray)
            .ignoresSafeArea()
        DayWeatherRowView()
    }
}
