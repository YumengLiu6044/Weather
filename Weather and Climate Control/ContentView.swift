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
                Text("Your locations are: \(location.longitude), \(location.latitude)")
            }
            else
            {
                if locationManager.isLoading{
                    ProgressView()
                }
                else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
            
        }
        .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(0.5)], startPoint: .top, endPoint: .bottom))
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        
        
    }
}

#Preview {
    ContentView()
}
