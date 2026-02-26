//
//  AppError.swift
//  WeatherNotes
//

import Foundation

enum AppError: LocalizedError {
    case noNetwork
    case badResponse(statusCode: Int)
    case decodingFailed
    case apiKeyMissing
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "No internet connection. Please check your network."
        case .badResponse(let code):
            return "Server returned an error (code: \(code))."
        case .decodingFailed:
            return "Failed to parse weather data."
        case .apiKeyMissing:
            return "API key is not configured."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
