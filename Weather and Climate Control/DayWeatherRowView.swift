//
//  DayWeatherRowView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/3/24.
//

import SwiftUI

struct DayWeatherRowView: View {
    var dayWeatherItem: DayWeatherItem = DayWeatherItem(dayName: "Monday", maxTemperature: 42, minTemperature: 18, temperatureUnit: "°C", weatherIconName: "")
    
   @State  var maxTemperature : Float = 0
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: dayWeatherItem.weatherIconName), transaction: Transaction(animation: .spring(response: 1, dampingFraction: 0.6, blendDuration: 0.5))) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                    
                case .failure:
                    Image(systemName: "questionmark.app")
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                    
                case .empty:
                    ProgressView()
                        .padding(.bottom, 5)
                    
                @unknown default:
                    EmptyView()
                }}
            .padding(.trailing, 10.0)
            Text(dayWeatherItem.dayName)
            Spacer()
            Text(String(dayWeatherItem.getAverageTemperature()) + dayWeatherItem.temperatureUnit)
                .font(.body)
            Gauge(value: dayWeatherItem.getAverageTemperature() / maxTemperature, in: /*@START_MENU_TOKEN@*/0...1/*@END_MENU_TOKEN@*/) {
                    
                }.frame(width: 120, height: 10)
            
        }
        .gaugeStyle(.linearCapacity)
        .font(.title2)
        .foregroundStyle(.white)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .listRowSeparator(.hidden)
        .listRowBackground(Rectangle()
            .foregroundStyle(.ultraThinMaterial)
        )
        .padding()
        .onAppear() {
            maxTemperature = (dayWeatherItem.temperatureUnit == "°C") ? 50 : 150
        }
    }
}

struct DayWeatherItem : Identifiable {
    let id: UUID = UUID()
    let dayName: String
    let maxTemperature: Float
    let minTemperature: Float
    let temperatureUnit: String
    let weatherIconName: String
    
    func getAverageTemperature() -> Float {
        return maxTemperature * 0.5 + minTemperature * 0.5
    }
}

#Preview {
    ZStack{
        Rectangle()
            .foregroundStyle(.gray)
            .ignoresSafeArea()
        DayWeatherRowView()
        
        
    }
}
