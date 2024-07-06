//
//  DayWeatherRowView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/3/24.
//

import SwiftUI

struct DayWeatherRowView: View {
    var dayWeatherItem: DayWeatherItem = DayWeatherItem(dayName: "Monday", maxTemperature: 42, minTemperature: 18, temperatureUnit: "°C", weatherIconName: "")
    
    @State private var maxTemperature: Double = 42
    @State private var minTemperature: Double = 10
    
    @State private var isLoading = true
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: dayWeatherItem.weatherIconName), transaction: Transaction(animation: .spring(response: 1, dampingFraction: 0.6, blendDuration: 0.5))) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                        .onAppear {
                            isLoading = false
                        }
                case .failure:
                    Image(systemName: "questionmark.app")
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                        .onAppear {
                            isLoading = false
                        }
                case .empty:
                    ProgressView()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                        .onAppear {
                            isLoading = true
                        }
                @unknown default:
                    EmptyView()
                        .onAppear {
                            isLoading = false
                        }
                }
            }
            .padding(.trailing, 10.0)
            
            Text(dayWeatherItem.dayName)
            
            Spacer()
            
            GaugeRow(gaugeData: GaugeData(minimunValue: self.minTemperature, maximimValue: self.maxTemperature, minimunTrackValue: dayWeatherItem.minTemperature, maximimTrackValue: dayWeatherItem.maxTemperature))
                .frame(width: 200, height: 5)
                .redacted(reason: isLoading ? .placeholder : [])
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .gaugeStyle(.linearCapacity)
        .font(.title2)
        .foregroundStyle(.white)
        .shadow(radius: 10)
        .listRowSeparator(.hidden)
        .listRowBackground(Rectangle().foregroundStyle(.ultraThinMaterial))
        .padding(.horizontal, 10.0)
        .onAppear {
            maxTemperature = (dayWeatherItem.temperatureUnit == "°C") ? 45 : 100
            minTemperature = (dayWeatherItem.temperatureUnit == "°C") ? 11 : 50
        }
    }
    
    private func normalizedTemperature() -> Double {
        let averageTemp = dayWeatherItem.getAverageTemperature()
        return max(0, min(averageTemp / maxTemperature, 1))
    }
}

struct DayWeatherItem: Identifiable {
    let id: UUID = UUID()
    let dayName: String
    let maxTemperature: Double
    let minTemperature: Double
    let temperatureUnit: String
    let weatherIconName: String
    
    func getAverageTemperature() -> Double {
        return (maxTemperature * 0.5 + minTemperature * 0.5)
    }
    
    func presentTemperatureRange() -> String {
        return "\(round(minTemperature * 10) / 10)\(temperatureUnit)-\(round(maxTemperature * 10) / 10)\(temperatureUnit)"
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
