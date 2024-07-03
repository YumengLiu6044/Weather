//
//  WelcomeView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                .background(Color(hue: 0.1, saturation: 0.1, brightness: 0))
            VStack {
                Text("Welcome to Yumeng's Weather App")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)

                
                Spacer()
                    .frame(maxHeight: 60)
                Text("Please share your location for weather data")
                    .font(.title2)
                    .padding()
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .clipShape(Capsule())
                
                
                
                
            }
            .foregroundStyle(Color(.white))
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .multilineTextAlignment(.center)
            .padding()
        }
        

    }
}

#Preview {
    WelcomeView()
}
