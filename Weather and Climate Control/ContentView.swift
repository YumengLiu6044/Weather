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
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                WeatherView(location: location)
                    
            }
            else
            {
                WelcomeView()
                    .environmentObject(locationManager)
            }
            
            
        }
        .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(0.9)], startPoint: .top, endPoint: .bottom))
        .background(Color(hue: 0.1, saturation: 0.1, brightness: 0))
        
        
    }
}

#Preview {
    ContentView()
}
