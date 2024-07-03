//
//  ContentView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import Foundation
import SwiftUI
import OpenMeteoSdk


struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather : WeatherData?
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(response: weather)
                }
                else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                
                            } catch networkingError.responseError{
                                print("Response Error")
                            } catch networkingError.dataError {
                                print("Data error")
                            } catch {
                                print("Unexpected error")
                            }
                            
                        }
                }
                    
            }
            else
            {
                if locationManager.isLoading{
                    LoadingView()
                
                }
                else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
            
        }
        .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(0.9)], startPoint: .top, endPoint: .bottom))
        .background(Color(hue: 0.1, saturation: 0.1, brightness: 0))
        
        
    }
}

#Preview {
    ContentView()
}
