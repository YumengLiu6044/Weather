//
//  RowItemView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/3/24.
//

import SwiftUI

struct HourRowItemView: View {
    
    @State private var isLoading = true
    var hourWeatherItem: HourWeatherItem = HourWeatherItem(hour: "Now", weatherIconName: "http://openweathermap.org/img/wn/01d@2x.png", temperature: 32, temperatureUnit: "°C")
    
    var body: some View {
        VStack{
            Text(hourWeatherItem.hour)

            AsyncImage(url: URL(string: hourWeatherItem.weatherIconName), transaction: Transaction(animation: .spring(response: 1, dampingFraction: 0.6, blendDuration: 0.5))) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        
                        .onAppear {
                            isLoading = false
                        }
                    
                case .failure:
                    Image(systemName: "questionmark.app")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        
                        .onAppear {
                            isLoading = false
                        }
                    
                case .empty:
                    ProgressView()
                        .padding(.bottom, 5)
                        
                        .onAppear {
                            isLoading = true
                        }
                    
                    
                @unknown default:
                    EmptyView()
                }}
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

struct HourWeatherItem : Identifiable {
    let id: UUID = UUID()
    let hour: String
    let weatherIconName: String
    let temperature: Float
    let temperatureUnit: String
    
    func presentTemperature() -> String {
        return "\(temperature) \(temperatureUnit)"
    }
    
}

#Preview {
    HourRowItemView()
        
}
