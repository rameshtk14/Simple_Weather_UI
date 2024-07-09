//
//  ContentView.swift
//  Weather
//
//  Created by RAMESH on 10/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack {
                CityTextView(city: "Bengaluru, Karnataka")
                MainWeatherView(imageName: isNight ? "moon.stars.fill" : "sunset.fill", temperature: 70)
            
                HStack(spacing:20) {
                    WeatherDayView(day: "MON", imageName: "snow", temperature: 26)
                    WeatherDayView(day: "TUE", imageName: "wind.snow", temperature: 36)
                    WeatherDayView(day: "WED", imageName: "cloud.sun.fill", temperature: 56)
                    WeatherDayView(day: "THU", imageName: "sunset.fill", temperature: 66)
                    WeatherDayView(day: "FRI", imageName: "sun.max.fill", temperature: 86)
                   
                }
               Spacer()
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", foregroundColor: .blue, backgroundColor: .white)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    
    var day: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text(day)
                .font(.system(size: 24, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct CityTextView: View {
    
    var city: String
    
    var body: some View {
        Text(city)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherView: View {
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing:20) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .foregroundColor(.white)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
        .padding()
    }
}

struct WeatherButton: View {
    
    var title :String
    var foregroundColor: Color
    var backgroundColor: Color
    var body: some View {
       
        Text(title)
            .frame(width: 200, height: 40)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .font(.system(size: 20, weight: .medium, design: .default))
            .cornerRadius(10)
    }
}
struct BackgroundView: View {
    
    @Binding var isNight:Bool

    var body: some View {
        LinearGradient(gradient: Gradient(colors:[isNight ? .black : .blue,isNight ? .gray: .white] ), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}
