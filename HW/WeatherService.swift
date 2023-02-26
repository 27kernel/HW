//
//  WeatherService.swift
//  HW
//
//  Created by Ruslan Baigeldiyev on 18.02.2023.
//

import Foundation

class WeatherService {

    let apiKey = "72178c9905a53bd897898b05bf32142f"
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"

    func fetchWeatherData(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)?q=\(city)&units=metric&appid=\(apiKey)")!

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(WeatherServiceError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(WeatherServiceError.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                let weatherData = WeatherData(from: weatherResponse)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

    func iconURL(for iconCode: String) -> URL {
        let iconURLString = "https://openweathermap.org/img/w/\(iconCode).png"
        return URL(string: iconURLString)!
    }

}

struct WeatherData {
    let cityName: String
    let temperature: Double
    let weatherDescription: String
    let iconCode: String

    init(from response: WeatherResponse) {
        self.cityName = response.name
        self.temperature = response.main.temp
        self.weatherDescription = response.weather.first?.description ?? ""
        self.iconCode = response.weather.first?.icon ?? ""
    }
}

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
}

enum WeatherServiceError: Error {
    case invalidResponse
    case invalidData
}
