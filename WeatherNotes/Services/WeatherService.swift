//
//  WeatherService.swift
//  WeatherNotes
//

import Foundation

// MARK: - Protocol

protocol WeatherServiceProtocol {
    func fetchWeather(city: String) async throws -> WeatherData
}

// MARK: - Implementation

final class WeatherService: WeatherServiceProtocol {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchWeather(city: String) async throws -> WeatherData {
        guard !Config.weatherAPIKey.isEmpty else {
            throw AppError.apiKeyMissing
        }

        var components = URLComponents(string: Config.weatherBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: Config.weatherAPIKey)
        ]

        guard let url = components?.url else {
            throw AppError.badResponse(statusCode: 0)
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(from: url)
        } catch {
            throw AppError.noNetwork
        }

        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw AppError.badResponse(statusCode: httpResponse.statusCode)
        }

        do {
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse.toWeatherData()
        } catch {
            throw AppError.decodingFailed
        }
    }
}
