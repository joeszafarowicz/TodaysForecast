//
//  ContentView.swift
//  TodaysForecast
//
//  Created by Joseph Szafarowicz on 1/8/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var weatherData = API()
    
    var body: some View {
        VStack {
            Text("Current location: \(locationManager.latitudeValue), \(locationManager.longitudeValue)")
                .font(.system(size: 15, weight: .regular, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
            Text("Currently: \(weatherData.currentCondition.capitalizingFirstLetter())")
                .font(.system(size: 15, weight: .regular, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
            Text("Temperature: \(weatherData.currentTemperature)°")
                .font(.system(size: 15, weight: .regular, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
            Text("Feels like: \(weatherData.feelsLikeTemperature)°")
                .font(.system(size: 15, weight: .regular, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

