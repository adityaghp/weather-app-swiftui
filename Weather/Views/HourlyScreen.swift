//
//  HourlyScreen.swift
//  Weather
//
//  Created by Aditya Ghorpade on 29/03/24.
//

import SwiftUI

struct HourlyScreen: View {
    
    var weather: ResponseBody
    @Binding var currentTheme: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(weather.hourly, id: \.dt) { hourly in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                        .overlay {
                            HStack {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("\(hourly.dt.formatted(date: .omitted, time: .shortened))")
                                        .foregroundStyle(Color.primary)
                                        .font(.title)
                                        .bold()
                                    
                                    Text("\(hourly.weather[0].main)")
                                        .foregroundStyle(Color.primary)
                                        .font(.title)
                                }
                                
                                Spacer()
                                
                                Text(hourly.temp.roundDouble() + "°")
                                    .foregroundStyle(Color.primary)
                                    .font(.system(size: 60))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            .padding()
                            .padding(.horizontal)
                        }
                }
            }
            .navigationTitle("Hourly Today")
            .navigationBarTitleDisplayMode(.large)
        }
        .background(Color.accentColor)
        .preferredColorScheme(currentTheme ? .dark : .light)
    }
}

#Preview {
    HourlyScreen(weather: previewWeather, currentTheme: .constant(false))
}
