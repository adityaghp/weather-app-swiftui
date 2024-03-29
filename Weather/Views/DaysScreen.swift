//
//  DaysScreen.swift
//  Weather
//
//  Created by Aditya Ghorpade on 29/03/24.
//

import SwiftUI

struct DaysScreen: View {
    var weather: ResponseBody
    @Binding var appTheme: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(weather.daily, id: \.dt) { daily in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                        .overlay {
                            HStack {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("\(daily.dt.formatted(.dateTime.month().day()))")
                                        .foregroundStyle(Color.primary)
                                        .font(.title)
                                        .bold()
                                    
                                    Text("\(daily.weather[0].main)")
                                        .foregroundStyle(Color.primary)
                                        .font(.title)
                                }
                                
                                Spacer()
                                
                                Text(daily.temp.max.roundDouble() + "°")
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
            .navigationTitle("Daily")
            .navigationBarTitleDisplayMode(.large)
        }
        .background(Color.accentColor)
        .preferredColorScheme(appTheme ? .dark : .light)
        
    }
}

#Preview {
    DaysScreen(weather: previewWeather, appTheme: .constant(false))
}
