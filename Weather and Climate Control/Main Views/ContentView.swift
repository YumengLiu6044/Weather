//
//  ContentView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import Foundation
import SwiftUI


struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State private var isLoadingWeatherView = false
    
    var body: some View {
        VStack {
            if isLoadingWeatherView {
                WeatherView(unitPreference: "celsius")
                    .environmentObject(locationManager)
            }
            else
            {
                WelcomeView(isLoading: $isLoadingWeatherView)
                    .environmentObject(locationManager)
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
