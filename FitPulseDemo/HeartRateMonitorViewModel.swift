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
import AVFoundation

@Observable
class HeartRateMonitorViewModel {
    var bpm = 0
    var minBPM = Int.max
    var maxBPM = Int.min
    var avgBPM = 0
    var errorMessage: String? = nil
    var isPulsing = false
    var isMonitoring = false
    
    private var bpmHistory: [Int] = []
    private var cancellable: AnyCancellable?
    private var vitalsProcessor = SmartSpectraVitalsProcessor.shared
    
    var bpmHistoryData: [BPMReading] {
        bpmHistory.enumerated().map { index, bpm in
            BPMReading(time: index, bpm: bpm)
        }
    }
    
    init() {
        configureSDK()
    }
    
    func configureSDK() {
        let sdk = SmartSpectraSwiftSDK.shared
        
        sdk.setApiKey(APIKeyManager.presageAPIKey)
        
        sdk.setHeadlessMode(true)
        
        sdk.setSmartSpectraMode(.continuous)
        
        sdk.setMeasurementDuration(30.0)
        sdk.setRecordingDelay(3)
        
        sdk.setCameraPosition(.front)
        
        sdk.showControlsInScreeningView(false)
        
        sdk.setShowFps(false)
    }
    
    func startMonitoring() {
        vitalsProcessor.startProcessing()
        vitalsProcessor.startRecording()
        isMonitoring = true
        
        cancellable = SmartSpectraSwiftSDK.shared
            .$metricsBuffer
            .compactMap { $0?.pulse.rate.last?.value }
            .sink { [weak self] newValue in
                self?.updateStats(with: Int(newValue))
            }
    }
    
    func updateStats(with newBPM: Int) {
        guard newBPM > 0 else { return }
        
        bpm = newBPM
        bpmHistory.append(newBPM)
        minBPM = min(newBPM, minBPM)
        maxBPM = max(newBPM, maxBPM)
        avgBPM = bpmHistory.reduce(0, +) / bpmHistory.count
        isPulsing.toggle()
    }
    
    func stopMonitoring() {
        vitalsProcessor.stopProcessing()
        vitalsProcessor.stopRecording()
        isMonitoring = false
        
        cancellable?.cancel()
        bpmHistory.removeAll()
        
        bpm = 0
        minBPM = Int.max
        maxBPM = Int.min
        avgBPM = 0
        errorMessage = nil
    }
    
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) {[weak self] granted in
            if !granted {
                self?.errorMessage = "Camera access required."
            }
        }
    }
}


struct BPMReading: Identifiable {
    let id = UUID()
    let time: Int
    let bpm: Int
}
