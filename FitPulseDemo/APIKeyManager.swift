//
//  API.swift
//  FitPulseDemo
//
//  Created by Amira Ajibola  on 7/28/25.
//

import Foundation

enum APIKeyManager {
    static var presageAPIKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "PresageAPIKey") as? String else { fatalError("Missing or empty API key in Info.plist") }
        
        return apiKey
    }
}
