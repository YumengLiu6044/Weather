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
                    .environmentObject(locationManager)
            }
            else
            {
                WelcomeView()
                    .environmentObject(locationManager)
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
