//
//  APIServices.swift
//  WeatherApp
//
//  Created by RAMESH on 09/07/24.
//

import Foundation
import CoreLocation


enum ErrorCases: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var description: String? {
        switch self {
        case .invalidURL : return "Invalid URL"
        case .invalidResponse : return "invalid Response"
        case .invalidData : return "invalid Data"
        }
    }
    
}
struct APIServices {
    
    static func fetchWeatherData(for location: CLLocation) async throws -> WeatherResponse? {
        let apiKey = "c41197401c0e07c6308ac4ae554ca204"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else { throw ErrorCases.invalidURL  }
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else { 
            throw ErrorCases.invalidResponse
        }
        do {
            return try JSONDecoder().decode(WeatherResponse.self, from: data)
        }
        catch(let error ) {
            print(error.localizedDescription)
            throw ErrorCases.invalidData
        }
    }
}
