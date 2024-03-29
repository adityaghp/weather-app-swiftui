//
//  WeatherView.swift
//  Weather
//
//  Created by Aditya Ghorpade on 29/03/24.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    @State var theme: Bool = false
    @State var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(weather.timezone)
                                .bold()
                                .font(.title)
                            
                            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                .fontWeight(.light)
                        }
                        //.frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Button {
                            showSheet = true
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .font(.largeTitle)
                                .foregroundStyle(Color.primary)
                        }

                    }
                    
                    Spacer()
                        .frame(height: 30)
                    
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: weather.current.weather[0].main == "Clear" ? "sun.max" : "cloud")
                                    .font(.system(size: 40))
                                
                                Text("\(weather.current.weather[0].main)")
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text(weather.current.temp.roundDouble() + "°")
                                .font(.system(size: 60))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        
                        HStack {
                            NavigationLink {
                                DaysScreen(weather: weather, appTheme: $theme)
                            } label: {
                                Text("Daily")
                                    .foregroundStyle(Color.primary)
                                    .frame(width: 70, height: 30)
                                    .background(.gray.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            
                            NavigationLink {
                                HourlyScreen(weather: weather, currentTheme: $theme)
                            } label: {
                                Text("Hourly")
                                    .foregroundStyle(Color.primary)
                                    .frame(width: 70, height: 30)
                                    .background(.gray.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        }
                        
                        Spacer()
                            .frame(height: 30)
                        
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Weather now")
                            .bold()
                            .padding(.bottom)
                        
                        HStack {
                            WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.daily[0].temp.min.roundDouble() + ("°")))
                            Spacer()
                            WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.daily[0].temp.max.roundDouble() + "°"))
                        }
                        
                        HStack {
                            WeatherRow(logo: "wind", name: "Wind speed", value: (weather.current.wind_speed.roundDouble() + " m/s"))
                            Spacer()
                            WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.current.humidity.roundDouble())%")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                    .background(.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color("AccentColor"))
            .preferredColorScheme(theme ? .dark : .light)
            .sheet(isPresented: $showSheet, content: {
                SettingsScreen(toggleColorTheme: $theme, currentTheme: $theme)
            })
        }
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}
