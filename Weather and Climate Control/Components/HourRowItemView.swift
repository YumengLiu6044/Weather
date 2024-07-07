//
//  RowItemView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/3/24.
//

import SwiftUI

struct HourRowItemView: View {
    
    @State private var isLoading = true
    var hourWeatherItem: HourWeatherItem = SampleData.sampleHourWeatherArray[0]
    
    var body: some View {
        VStack{
            Text(hourWeatherItem.hour)

            OnlineImageView(imageURL: hourWeatherItem.weatherIconName, isLoading: $isLoading)
                .frame(width:50)
            Text(hourWeatherItem.presentTemperature())
            
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .font(.title2)
        .foregroundStyle(Color(.white))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .padding(5.0)
        .clipShape(.rect(cornerRadius: 7))
        
        
    }
}

#Preview {
    HourRowItemView()
        
}
