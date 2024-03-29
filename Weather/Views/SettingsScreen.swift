//
//  SettingsScreen.swift
//  Weather
//
//  Created by Aditya Ghorpade on 29/03/24.
//

import SwiftUI

struct SettingsScreen: View {
    @Binding var toggleColorTheme: Bool
    @Binding var currentTheme: Bool
    @State var toggleCelcius: Bool = true
    @State var toggleKelvin: Bool = false
    @Environment(\.dismiss) var dissmiss
    @State private var units: String = "Celcius"
    
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .bold()
                    .font(.title)
                    .padding()
                
                Spacer()
                Button {
                    dissmiss()
                } label: {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.gray.opacity(0.5))
                        .overlay {
                            Image(systemName: "xmark")
                                .foregroundStyle(.black)
                                .padding(.horizontal)
                                .padding()
                        }
                        .padding()
                }
            }
            List {
                Section("Theme") {
                    Toggle("Dark mode", isOn: $toggleColorTheme)
                }
                
                Section("Metrics") {
                    Picker("Picker", selection: $units) {
                        Text("Celsius").tag("Celcius")
                        Text("Fahrenhiet").tag("Fahrenhiet")
                        Text("Kelvins").tag("Kelvins")
                    }
                    .pickerStyle(.segmented)
                }
            }
        
        }
        .preferredColorScheme(currentTheme ? .dark : .light)
    }
}

#Preview {
    SettingsScreen(toggleColorTheme: .constant(false), currentTheme: .constant(false))
}
