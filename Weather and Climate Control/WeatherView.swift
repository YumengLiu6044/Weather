//
//  ContentView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import SwiftUI
import OpenMeteoSdk

struct WeatherView: View {
    var response: WeatherData
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                .background(Color(hue: 0.1, saturation: 0.1, brightness: 0))
            
        }
        .onAppear {
            for i in response.daily.time {
                print(getWeekdayName(from: i))
            }
        }
    }
    
    
}

