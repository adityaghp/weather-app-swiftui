//
//  ContentView.swift
//  Weather
//
//  Created by Aditya Ghorpade on 28/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State var responseError: Bool = false
    
    var body: some View {
        VStack {
            if responseError {
                Text("An unexpected error occured")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                if let location = locationManager.location {
                    if let weather = weather {
                        WeatherView(weather: weather)
                    } else {
                        LoadingView()
                            .task {
                                do {
                                    weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                } catch {
                                    print("Error getting weather: \(error)")
                                    responseError = true
                                }
                            }
                    }
                } else {
                    if locationManager.isLoading {
                        LoadingView()
                    } else {
                        WelcomeScreen()
                            .environmentObject(locationManager)
                    }
                }
            }
        }
        .background(Color("AccentColor"))
        .alert("Error!", isPresented: $responseError) {
            Button("Retry", role: .cancel) {}
            Button("Close", role: .destructive) { exit(0) }
        } message: {
            Text("Please check your internet connection!")
        }
    }
}

#Preview {
    ContentView()
}
