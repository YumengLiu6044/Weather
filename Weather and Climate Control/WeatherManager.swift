import Foundation
import CoreLocation
import OpenMeteoSdk

let weatherCodeIconMapping = [
    "0": ["day": ["description": "Sunny", "image": "01d@2x.png"], "night": ["description": "Clear", "image": "01n@2x.png"]], "1": ["day": ["description": "Mainly Sunny", "image": "01d@2x.png"], "night": ["description": "Mainly Clear", "image": "01n@2x.png"]], "2": ["day": ["description": "Partly Cloudy", "image": "02d@2x.png"], "night": ["description": "Partly Cloudy", "image": "02n@2x.png"]], "3": ["day": ["description": "Cloudy", "image": "03d@2x.png"], "night": ["description": "Cloudy", "image": "03n@2x.png"]], "45": ["day": ["description": "Foggy", "image": "50d@2x.png"], "night": ["description": "Foggy", "image": "50n@2x.png"]], "48": ["day": ["description": "Rime Fog", "image": "50d@2x.png"], "night": ["description": "Rime Fog", "image": "50n@2x.png"]], "51": ["day": ["description": "Light Drizzle", "image": "09d@2x.png"], "night": ["description": "Light Drizzle", "image": "09n@2x.png"]], "53": ["day": ["description": "Drizzle", "image": "09d@2x.png"], "night": ["description": "Drizzle", "image": "09n@2x.png"]], "55": ["day": ["description": "Heavy Drizzle", "image": "09d@2x.png"], "night": ["description": "Heavy Drizzle", "image": "09n@2x.png"]], "56": ["day": ["description": "Light Freezing Drizzle", "image": "09d@2x.png"], "night": ["description": "Light Freezing Drizzle", "image": "09n@2x.png"]], "57": ["day": ["description": "Freezing Drizzle", "image": "09d@2x.png"], "night": ["description": "Freezing Drizzle", "image": "09n@2x.png"]], "61": ["day": ["description": "Light Rain", "image": "10d@2x.png"], "night": ["description": "Light Rain", "image": "10n@2x.png"]], "63": ["day": ["description": "Rain", "image": "10d@2x.png"], "night": ["description": "Rain", "image": "10n@2x.png"]], "65": ["day": ["description": "Heavy Rain", "image": "10d@2x.png"], "night": ["description": "Heavy Rain", "image": "10n@2x.png"]], "66": ["day": ["description": "Light Freezing Rain", "image": "10d@2x.png"], "night": ["description": "Light Freezing Rain", "image": "10n@2x.png"]], "67": ["day": ["description": "Freezing Rain", "image": "10d@2x.png"], "night": ["description": "Freezing Rain", "image": "10n@2x.png"]], "71": ["day": ["description": "Light Snow", "image": "13d@2x.png"], "night": ["description": "Light Snow", "image": "13n@2x.png"]], "73": ["day": ["description": "Snow", "image": "13d@2x.png"], "night": ["description": "Snow", "image": "13n@2x.png"]], "75": ["day": ["description": "Heavy Snow", "image": "13d@2x.png"], "night": ["description": "Heavy Snow", "image": "13n@2x.png"]], "77": ["day": ["description": "Snow Grains", "image": "13d@2x.png"], "night": ["description": "Snow Grains", "image": "13n@2x.png"]], "80": ["day": ["description": "Light Showers", "image": "09d@2x.png"], "night": ["description": "Light Showers", "image": "09n@2x.png"]], "81": ["day": ["description": "Showers", "image": "09d@2x.png"], "night": ["description": "Showers", "image": "09n@2x.png"]], "82": ["day": ["description": "Heavy Showers", "image": "09d@2x.png"], "night": ["description": "Heavy Showers", "image": "09n@2x.png"]], "85": ["day": ["description": "Light Snow Showers", "image": "13d@2x.png"], "night": ["description": "Light Snow Showers", "image": "13n@2x.png"]], "86": ["day": ["description": "Snow Showers", "image": "13d@2x.png"], "night": ["description": "Snow Showers", "image": "13n@2x.png"]], "95": ["day": ["description": "Thunderstorm", "image": "11d@2x.png"], "night": ["description": "Thunderstorm", "image": "11n@2x.png"]], "96": ["day": ["description": "Light Thunderstorms With Hail", "image": "11d@2x.png"], "night": ["description": "Light Thunderstorms With Hail", "image": "11n@2x.png"]], "99": ["day": ["description": "Thunderstorm With Hail", "image": "11d@2x.png"], "night": ["description": "Thunderstorm With Hail", "image": "11n@2x.png"]]]


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

}

func getWeekdayName(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE"
    let weekdayName = dateFormatter.string(from: date)
    return weekdayName
}

func getCurrentShortDateString(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d"
    let dateString = dateFormatter.string(from: date)
    return dateString
}

func getHourinAMPMFormat(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h a"  // 'h' for 12-hour format and 'a' for AM/PM
    return dateFormatter.string(from: date)
}

func getWeatherIconName(code: Int, isDay: Int) -> String {
    let timeOfDay = (isDay == 1) ? "day" : "night"
    if let weatherData = weatherCodeIconMapping[String(code)],
       let timeData = weatherData[timeOfDay],
       let imageName = timeData["image"] {
        return "https://openweathermap.org/img/wn/" + imageName
    }
    return "None"
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
        let time: Date
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
        let time: [Date]
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
        let time: [Date]
        let weather_code: [Int]
        let temperature_2m_max: [Double]
        let temperature_2m_min: [Double]
    }
}


enum networkingError : Error {
    case responseError, dataError
}

func loadCurrentWeather(_ response: WeatherData) -> CurrentWeather {
    return CurrentWeather(
        dayName: getWeekdayName(from: response.current.time),
        date: getCurrentShortDateString(from: response.current.time),
        temperature: response.current.temperature_2m,
        temperatureUnit: response.current_units.temperature_2m,
        weatherIconName: getWeatherIconName(code: response.current.weather_code, isDay: response.current.is_day))
}

func isSameDateAndHour(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    
    let components1 = calendar.dateComponents([.year, .month, .day, .hour], from: date1)
    let components2 = calendar.dateComponents([.year, .month, .day, .hour], from: date2)
    
    return components1.year == components2.year &&
           components1.month == components2.month &&
           components1.day == components2.day &&
           components1.hour == components2.hour
}

func isDayTime(date: Date) -> Int {
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    
    if hour >= 6 && hour < 18 {
        return 1  // Day time
    } else {
        return 0  // Night time
    }
}

func loadHourWeather(_ response: WeatherData) -> [HourWeatherItem] {
    var hourArray: [HourWeatherItem] = []
    let currentTime = Date()
    var hourStartIndex = 0
    
    while !isSameDateAndHour(date1: currentTime, date2: response.hourly.time[hourStartIndex]) {
        hourStartIndex += 1
    }
    let hourlyData = response.hourly
    
    for i in 0...23 {
        hourArray.append(HourWeatherItem(
            hour: getHourinAMPMFormat(from: hourlyData.time[i + hourStartIndex]),
            weatherIconName: getWeatherIconName(code: hourlyData.weather_code[i + hourStartIndex], isDay: isDayTime(date: hourlyData.time[i + hourStartIndex])),
            temperature: hourlyData.temperature_2m[i + hourStartIndex],
            temperatureUnit: response.hourly_units.temperature_2m
        ))
    }
    return hourArray
    
}

func loadDailyWeather(_ response: WeatherData) -> [DayWeatherItem] {
    var dayArray: [DayWeatherItem] = []
    let dailyData = response.daily
    
    for i in 0..<dailyData.time.count {
        dayArray.append(DayWeatherItem(
            dayName: getWeekdayName(from: dailyData.time[i]),
            maxTemperature: dailyData.temperature_2m_max[i],
            minTemperature: dailyData.temperature_2m_min[i],
            temperatureUnit: response.daily_units.temperature_2m_min,
            weatherIconName: getWeatherIconName(code: dailyData.weather_code[i], isDay: 1))
        )
    }
    return dayArray
}
