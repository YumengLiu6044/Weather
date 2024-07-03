//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Stephanie Diep on 2021-11-30.
//

import Foundation
import CoreLocation
import OpenMeteoSdk


class WeatherManager {
    // HTTP request to get the current weather depending on the coordinates we got from LocationManager
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> [WeatherApiResponse] {
        let localTimeZoneIdentifier: String = TimeZone.current.identifier
        let timeZoneComponents: [String] = localTimeZoneIdentifier.components(separatedBy: "/")
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=weather_code,temperature_2m_max,temperature_2m_min&timeformat=unixtime&timezone=\(timeZoneComponents[0])%2F\(timeZoneComponents[1])&format=flatbuffers") else { fatalError("Missing URL") }


        return try await WeatherApiResponse.fetch(url: url)
    }
}


// Model of the response body we get from calling the OpenWeather API
struct ResponseBody {
    let current: Current
    let daily: Daily

    struct Current {
        let time: Date
        let temperature2m: Float
    }
    struct Daily {
        let time: [Date]
        let weatherCode: [Float]
        let temperature2mMax: [Float]
        let temperature2mMin: [Float]
    }

}
