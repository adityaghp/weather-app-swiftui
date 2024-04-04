//
//  DataModel.swift
//  Weather
//
//  Created by Aditya Ghorpade on 28/03/24.
//

import Foundation

struct ResponseBody: Codable {
    struct Current: Codable {
        let dt: Date
        let temp: Double
        let wind_speed: Double
        let humidity: Double
        let weather: [Weather]
        struct Weather: Codable {
            let id: Int
            let main: String
        }
    }
    
    struct Hourly: Codable {
        let dt: Date
        let temp: Double
        let weather: [Weather]
        struct Weather: Codable {
            let id: Int
            let main: String
        }
    }
    
    struct Daily: Codable {
        let dt: Date
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
        let temp: Temp
        let humidity: Int
        let wind_speed: Double
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        let weather: [Weather]
        let clouds: Int
        let pop: Double
    }
    
    let timezone: String
    let current: Current
    let daily: [Daily]
    let hourly: [Hourly]
}

//An enum to for weather errors
enum WeatherError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
}

