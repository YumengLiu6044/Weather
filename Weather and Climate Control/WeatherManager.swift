import Foundation
import CoreLocation
import OpenMeteoSdk


class WeatherManager {
    // HTTP request to get the current weather depending on the coordinates we got from LocationManager
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherData {
        let localTimeZoneIdentifier: String = TimeZone.current.identifier
        let timeZoneComponents: [String] = localTimeZoneIdentifier.components(separatedBy: "/")
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=weather_code,temperature_2m_max,temperature_2m_min&timeformat=unixtime&timezone=\(timeZoneComponents[0])%2F\(timeZoneComponents[1])&format=json") else { fatalError("Missing URL") }
        
        print(url)
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
}


// Model of the response body we get from calling the API

// Model of the response body we get from calling the API
struct WeatherData: Decodable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Int
    let daily_units: DailyUnits
    let daily: Daily

    struct DailyUnits: Decodable {
        let time: String
        let weather_code: String
        let temperature_2m_max: String
        let temperature_2m_min: String
    }

    struct Daily: Decodable {
        let time: [Date]
        let weather_code: [Int]
        let temperature_2m_max: [Float]
        let temperature_2m_min: [Float]
    }
}

// Function to get the weekday name from a Date object
func getWeekdayName(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE" // EEEE gives the full name of the weekday
    let weekdayName = dateFormatter.string(from: date)
    return weekdayName
}

enum networkingError : Error {
    case responseError, dataError
}
