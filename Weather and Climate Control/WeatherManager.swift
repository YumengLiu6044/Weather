import Foundation
import CoreLocation
import OpenMeteoSdk


class WeatherManager {
    // HTTP request to get the current weather depending on the coordinates we got from LocationManager
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherData {
        let localTimeZoneIdentifier: String = TimeZone.current.identifier
        let timeZoneComponents: [String] = localTimeZoneIdentifier.components(separatedBy: "/")
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,is_day,weather_code&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timeformat=unixtime&timezone=\(timeZoneComponents[0])%2F\(timeZoneComponents[1])&format=json") else { fatalError("Missing URL") }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkingError.responseError
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            return try decoder.decode(WeatherData.self, from: data)
        } catch {
            throw networkingError.dataError
        }
    
    }
    
    func getWeekdayName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // EEEE gives the full name of the weekday
        let weekdayName = dateFormatter.string(from: date)
        return weekdayName
    }
}

// Model of the response body we get from calling the API

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Int
    let current_units: CurrentUnits
    let current: Current
    let hourly_units: HourlyUnits
    let hourly: Hourly
    let daily_units: DailyUnits
    let daily: Daily

    struct CurrentUnits: Codable {
        let time: String
        let interval: String
        let temperature_2m: String
        let is_day: String
        let weather_code: String
    }

    struct Current: Codable {
        let time: Int
        let interval: Int
        let temperature_2m: Float
        let is_day: Int
        let weather_code: Int
    }

    struct HourlyUnits: Codable {
        let time: String
        let temperature_2m: String
        let weather_code: String
    }

    struct Hourly: Codable {
        let time: [Int]
        let temperature_2m: [Float]
        let weather_code: [Int]
    }

    struct DailyUnits: Codable {
        let time: String
        let weather_code: String
        let temperature_2m_max: String
        let temperature_2m_min: String
    }

    struct Daily: Codable {
        let time: [Int]
        let weather_code: [Int]
        let temperature_2m_max: [Float]
        let temperature_2m_min: [Float]
    }
}


enum networkingError : Error {
    case responseError, dataError
}
