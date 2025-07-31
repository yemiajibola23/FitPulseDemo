//
//  HeartRateMonitorViewModel.swift
//  FitPulseDemo
//
//  Created by Amira Ajibola  on 7/30/25.
//

import Foundation
import SmartSpectraSwiftSDK
import Combine
import SwiftUI

@Observable
class HeartRateMonitorViewModel {
    var bpm: Int?
    var minBPM = Int.max
    var maxBPM = Int.min
    var avgBPM = 0
    var errorMessage: String? = nil
    
    private var history: [Int] = []
    private var cancellable: AnyCancellable?
    
    func configureSDK() {
        let sdk = SmartSpectraSwiftSDK.shared
        
        sdk.setApiKey(APIKeyManager.presageAPIKey)
        
        sdk.setHeadlessMode(true)
        
        sdk.setSmartSpectraMode(.continuous)
        
        sdk.setMeasurementDuration(1.0)
        sdk.setRecordingDelay(0)
        
        sdk.setCameraPosition(.back)
        
        sdk.showControlsInScreeningView(false)
        
        sdk.setShowFps(false)
        
        SmartSpectraVitalsProcessor.shared.startProcessing()
    }
    
    func startMonitoring() {
        configureSDK()
        
        cancellable = SmartSpectraSwiftSDK.shared
            .$metricsBuffer
            .compactMap { $0?.pulse.rate.last?.value }
            .sink { [weak self] newValue in
                self?.updateStats(with: Int(newValue))
            }
    }
    
    private func updateStats(with newBPM: Int) {
        bpm = newBPM
        history.append(newBPM)
        minBPM = min(newBPM, minBPM)
        maxBPM = max(newBPM, maxBPM)
        avgBPM = history.reduce(0, +) / history.count
    }
    
    func stopMonitoring() {
        cancellable?.cancel()
        history.removeAll()
        
        bpm = nil
        minBPM = Int.max
        maxBPM = Int.min
        avgBPM = 0
    }
}


