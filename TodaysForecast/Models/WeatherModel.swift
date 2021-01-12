//
//  WeatherModel.swift
//  TodaysForecast
//
//  Created by Joseph Szafarowicz on 1/9/21.
//

import Foundation

struct OpenWeatherCurrent: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone, timezoneOffset = "timezone_offset", current
    }
}

struct Current: Codable {
    let temp: Double
    let feelsLike: Double
    let currentWeather: [CurrentWeather]

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case currentWeather = "weather"
    }
}

struct CurrentWeather: Codable {
    let main: String

    enum CodingKeys: String, CodingKey {
        case main
    }
}

class API: ObservableObject {
    @Published var currentCondition = ""
    @Published var currentTemperature = 0
    @Published var feelsLikeTemperature = 0
    
    init() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(LocationManager().latitudeValue)&lon=\(LocationManager().longitudeValue)&units=imperial&exclude=minutely,hourly,daily&appid=APIKey") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
              do {
                let decodedResponse = try JSONDecoder().decode(OpenWeatherCurrent.self, from: data)
                
                DispatchQueue.main.async {
                    self.currentCondition = decodedResponse.current.currentWeather[0].main.lowercased()
                    self.currentTemperature = Int(decodedResponse.current.temp)
                    self.feelsLikeTemperature = Int(decodedResponse.current.feelsLike)
                }
              } catch {
                debugPrint(error)
                print(error.localizedDescription)
              }
              return
            }
        }.resume()
    }
}
