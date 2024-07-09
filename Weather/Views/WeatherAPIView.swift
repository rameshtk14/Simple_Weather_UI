//
//  WeatherAPIView.swift
//  WeatherApp
//
//  Created by RAMESH on 09/07/24.
//

import SwiftUI
import CoreLocation

struct WeatherAPIView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var weatherData: WeatherData?
    
    var body: some View {
        VStack {
            if let weatherData = weatherData {
                Text("\(Int(weatherData.temperature))°C")
                    .font(.custom("", size: 70))
                    .padding()
                VStack {
                    Text(weatherData.locationName)
                        .font(.title2).bold()
                    Text(weatherData.condition)
                        .font(.body).bold()
                        .foregroundStyle(.gray)
                }
                Spacer()
                Text("Current Weather")
                    .bold()
                    .padding()
                    .foregroundStyle(.gray)
            }else {
                ProgressView()
            }
        }
        .frame(width: 300, height: 300)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .onAppear() {
            locationManager.requestLocation()
        }
        .onReceive(locationManager.$location) { location in
            guard let location = location else { return }
            Task {
                guard let weatherDataResponse = try await APIServices.fetchWeatherData(for: location ) else { return }
                DispatchQueue.main.async {
                    weatherData = WeatherData(locationName: weatherDataResponse.name, temperature: weatherDataResponse.main.temp, condition: weatherDataResponse.weather.first?.description ?? "")
                }
            }
        }
    }
}

#Preview {
    WeatherAPIView()
}
