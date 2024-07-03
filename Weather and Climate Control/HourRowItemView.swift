//
//  RowItemView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/3/24.
//

import SwiftUI

struct HourRowItemView: View {
    var dayWeatherItem: hourWeatherItem = hourWeatherItem(hour: "Now", weatherIconName: "http://openweathermap.org/img/wn/01d@2x.png", temperature: 32, temperatureUnit: "°C")
    
    var body: some View {
        VStack{
            Text(dayWeatherItem.hour)

            AsyncImage(url: URL(string: dayWeatherItem.weatherIconName), transaction: Transaction(animation: .spring(response: 1, dampingFraction: 0.6, blendDuration: 0.5))) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    
                case .failure:
                    Image(systemName: "questionmark.app")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    
                case .empty:
                    ProgressView()
                        .padding(.bottom, 5)
                    
                @unknown default:
                    EmptyView()
                }}
            Text(dayWeatherItem.presentTemperature())
            
        }
        .font(.title2)
        .foregroundStyle(Color(.white))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .padding(10.0)
        .clipShape(.rect(cornerRadius: 7))
        
        
    }
}

struct hourWeatherItem : Identifiable {
    let id: UUID = UUID()
    let hour: String
    let weatherIconName: String
    let temperature: Float
    let temperatureUnit: String
    
    func presentTemperature() -> String {
        return "\(temperature)\(temperatureUnit)"
    }
    
}

#Preview {
    HourRowItemView()
        
}
