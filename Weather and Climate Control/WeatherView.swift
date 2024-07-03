//
//  ContentView.swift
//  Weather and Climate Control
//
//  Created by Yumeng Liu on 7/2/24.
//

import SwiftUI
import OpenMeteoSdk

struct WeatherView: View {
    var response: WeatherData?
    var cityName: String = "Your location"
    var weatherCodeIconMapping : [String: Any] = [
        "0":[
            "day":[
                "description":"Sunny",
                "image":"http://openweathermap.org/img/wn/01d@2x.png"
            ],
            "night":[
                "description":"Clear",
                "image":"http://openweathermap.org/img/wn/01n@2x.png"
            ]
        ],
        "1":[
            "day":[
                "description":"Mainly Sunny",
                "image":"http://openweathermap.org/img/wn/01d@2x.png"
            ],
            "night":[
                "description":"Mainly Clear",
                "image":"http://openweathermap.org/img/wn/01n@2x.png"
            ]
        ],
        "2":[
            "day":[
                "description":"Partly Cloudy",
                "image":"http://openweathermap.org/img/wn/02d@2x.png"
            ],
            "night":[
                "description":"Partly Cloudy",
                "image":"http://openweathermap.org/img/wn/02n@2x.png"
            ]
        ],
        "3":[
            "day":[
                "description":"Cloudy",
                "image":"http://openweathermap.org/img/wn/03d@2x.png"
            ],
            "night":[
                "description":"Cloudy",
                "image":"http://openweathermap.org/img/wn/03n@2x.png"
            ]
        ],
        "45":[
            "day":[
                "description":"Foggy",
                "image":"http://openweathermap.org/img/wn/50d@2x.png"
            ],
            "night":[
                "description":"Foggy",
                "image":"http://openweathermap.org/img/wn/50n@2x.png"
            ]
        ],
        "48":[
            "day":[
                "description":"Rime Fog",
                "image":"http://openweathermap.org/img/wn/50d@2x.png"
            ],
            "night":[
                "description":"Rime Fog",
                "image":"http://openweathermap.org/img/wn/50n@2x.png"
            ]
        ],
        "51":[
            "day":[
                "description":"Light Drizzle",
                "image":"http://openweathermap.org/img/wn/09d@2x.png"
            ],
            "night":[
                "description":"Light Drizzle",
                "image":"http://openweathermap.org/img/wn/09n@2x.png"
            ]
        ],
        "53":[
            "day":[
                "description":"Drizzle",
                "image":"http://openweathermap.org/img/wn/09d@2x.png"
            ],
            "night":[
                "description":"Drizzle",
                "image":"http://openweathermap.org/img/wn/09n@2x.png"
            ]
        ],
        "55":[
            "day":[
                "description":"Heavy Drizzle",
                "image":"http://openweathermap.org/img/wn/09d@2x.png"
            ],
            "night":[
                "description":"Heavy Drizzle",
                "image":"http://openweathermap.org/img/wn/09n@2x.png"
            ]
        ],
        "56":[
            "day":[
                "description":"Light Freezing Drizzle",
                "image":"http://openweathermap.org/img/wn/09d@2x.png"
            ],
            "night":[
                "description":"Light Freezing Drizzle",
                "image":"http://openweathermap.org/img/wn/09n@2x.png"
            ]
        ],
        "57":[
            "day":[
                "description":"Freezing Drizzle",
                "image":"http://openweathermap.org/img/wn/09d@2x.png"
            ],
            "night":[
                "description":"Freezing Drizzle",
                "image":"http://openweathermap.org/img/wn/09n@2x.png"
            ]
        ],
        "61":[
            "day":[
                "description":"Light Rain",
                "image":"http://openweathermap.org/img/wn/10d@2x.png"
            ],
            "night":[
                "description":"Light Rain",
                "image":"http://openweathermap.org/img/wn/10n@2x.png"
            ]
        ],
        "63":[
            "day":[
                "description":"Rain",
                "image":"http://openweathermap.org/img/wn/10d@2x.png"
            ],
            "night":[
                "description":"Rain",
                "image":"http://openweathermap.org/img/wn/10n@2x.png"
            ]
        ],
        "65":[
            "day":[
                "description":"Heavy Rain",
                "image":"http://openweathermap.org/img/wn/10d@2x.png"
            ],
            "night":[
                "description":"Heavy Rain",
                "image":"http://openweathermap.org/img/wn/10n@2x.png"
            ]
        ],
        "66":[
            "day":[
                "description":"Light Freezing Rain",
                "image":"http://openweathermap.org/img/wn/10d@2x.png"
            ],
            "night":[
                "description":"Light Freezing Rain",
                "image":"http://openweathermap.org/img/wn/10n@2x.png"
            ]
        ],
        "67":[
            "day":[
                "description":"Freezing Rain",
                "image":"http://openweathermap.org/img/wn/10d@2x.png"
            ],
            "night":[
                "description":"Freezing Rain",
                "image":"http://openweathermap.org/img/wn/10n@2x.png"
            ]
        ],
        "71":[
            "day":[
                "description":"Light Snow",
                "image":"http://openweathermap.org/img/wn/13d@2x.png"
            ],
            "night":[
                "description":"Light Snow",
                "image":"http://openweathermap.org/img/wn/13n@2x.png"
            ]
        ],
        "73":[
            "day":[
                "description":"Snow",
                "image":"http://openweathermap.org/img/wn/13d@2x.png"
            ],
            "night":[
                "description":"Snow",
                "image":"http://openweathermap.org/img/wn/13n@2x.png"
            ]
        ],
        "75":[
            "day":[
                "description":"Heavy Snow",
                "image":"http://openweathermap.org/img/wn/13d@2x.png"
            ],
            "night":[
                "description":"Heavy Snow",
                "image":"http://openweathermap.org/img/wn/13n@2x.png"
            ]
        ],
        "77":[
            "day":[
                "description":"Snow Grains",
                "image":"http://openweathermap.org/img/wn/13d@2x.png"
            ],
            "night":[
                "description":"Snow Grains",
                "image":"http://openweathermap.org/img/wn/13n@2x.png"
            ]
        ],
        "80":[
            "day":[
                "description":"Light Showers",
                "image":"http://openweathermap.org/img/wn/09d@2x.png"
            ],
            "night":[
                "description":"Light Showers",
                "image":"http://openweathermap.org/img/wn/09n@2x.png"
            ]
        ],
        "81":[
            "day":[
                "description":"Showers",
                "image":"http://openweathermap.org/img/wn/09d@2x.png"
            ],
            "night":[
                "description":"Showers",
                "image":"http://openweathermap.org/img/wn/09n@2x.png"
            ]
        ],
        "82":[
            "day":[
                "description":"Heavy Showers",
                "image":"http://openweathermap.org/img/wn/09d@2x.png"
            ],
            "night":[
                "description":"Heavy Showers",
                "image":"http://openweathermap.org/img/wn/09n@2x.png"
            ]
        ],
        "85":[
            "day":[
                "description":"Light Snow Showers",
                "image":"http://openweathermap.org/img/wn/13d@2x.png"
            ],
            "night":[
                "description":"Light Snow Showers",
                "image":"http://openweathermap.org/img/wn/13n@2x.png"
            ]
        ],
        "86":[
            "day":[
                "description":"Snow Showers",
                "image":"http://openweathermap.org/img/wn/13d@2x.png"
            ],
            "night":[
                "description":"Snow Showers",
                "image":"http://openweathermap.org/img/wn/13n@2x.png"
            ]
        ],
        "95":[
            "day":[
                "description":"Thunderstorm",
                "image":"http://openweathermap.org/img/wn/11d@2x.png"
            ],
            "night":[
                "description":"Thunderstorm",
                "image":"http://openweathermap.org/img/wn/11n@2x.png"
            ]
        ],
        "96":[
            "day":[
                "description":"Light Thunderstorms With Hail",
                "image":"http://openweathermap.org/img/wn/11d@2x.png"
            ],
            "night":[
                "description":"Light Thunderstorms With Hail",
                "image":"http://openweathermap.org/img/wn/11n@2x.png"
            ]
        ],
        "99":[
            "day":[
                "description":"Thunderstorm With Hail",
                "image":"http://openweathermap.org/img/wn/11d@2x.png"
            ],
            "night":[
                "description":"Thunderstorm With Hail",
                "image":"http://openweathermap.org/img/wn/11n@2x.png"
            ]
        ]
    ]
    var hourWeatherArray: [hourWeatherItem] = [
        hourWeatherItem(hour: "Now", weatherIconName: "", temperature: 32, temperatureUnit: "°C"),
        hourWeatherItem(hour: "10AM", weatherIconName: "", temperature: 36, temperatureUnit: "°C"),
        hourWeatherItem(hour: "11AM", weatherIconName: "", temperature: 38, temperatureUnit: "°C"),
        hourWeatherItem(hour: "12AM", weatherIconName: "", temperature: 39, temperatureUnit: "°C"),
        hourWeatherItem(hour: "1PM", weatherIconName: "", temperature: 40, temperatureUnit: "°C"),
        hourWeatherItem(hour: "2PM", weatherIconName: "", temperature: 41, temperatureUnit: "°C"),
        hourWeatherItem(hour: "3PM", weatherIconName: "", temperature: 41, temperatureUnit: "°C"),
        hourWeatherItem(hour: "4PM", weatherIconName: "", temperature: 38, temperatureUnit: "°C"),
        hourWeatherItem(hour: "5PM", weatherIconName: "", temperature: 38, temperatureUnit: "°C")
    ]
    
    @State private var isVisible = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.linearGradient(colors: [.blue, .blue.opacity(1)], startPoint: .top, endPoint: .bottom))
                .background(Color(hue: 0.1, saturation: 0.1, brightness: 0))
            
            if isVisible {
                VStack(spacing: 20) {
                    Text(cityName)
                        .font(.system(size: 50))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.white))
                        .shadow(radius: 10)
                        .transition(.slide)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 5){
                            ForEach(hourWeatherArray) { day in
                                HourRowItemView(dayWeatherItem: day)
                                    .scrollTransition {
                                        content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1 : 0)
                                    }
                                
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    .transition(.slide)
                    
                    ScrollView(.vertical) {
                        
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    
                    .transition(.slide)
                    
                    
                    
                }
                
                .padding(20.0)
                .transition(.blurReplace)
            }
            
        }
        .onAppear {
            withAnimation {
                isVisible = true
            }
        }
        
    }
    
}


#Preview {
    WeatherView()
}
