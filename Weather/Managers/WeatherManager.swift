//
//  WeatherManager.swift
//  Weather
//
//  Created by Aditya Ghorpade on 28/03/24.
//

import Foundation
import CoreLocation

class WeatherManager: ObservableObject {
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely,alerts&appid=00194c8993d4328d820774f7577a13c2&units=metric") else { throw WeatherError.invalidURL }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            print(data.description)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw WeatherError.invalidResponse
            }
            
            let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
            
            return decodedData
        } catch {
            throw WeatherError.requestFailed(error)
        }
    }
}

