//
//  ContentView.swift
//  FitPulseDemo
//
//  Created by Amira Ajibola  on 7/28/25.
//

import SwiftUI
import SmartSpectraSwiftSDK

struct HeartRateView: View {
    @Bindable var viewModel = HeartRateMonitorViewModel()
    
    var body: some View {
        VStack(spacing: 14) {
            if let bpm = viewModel.bpm {
                Text("BPM: \(bpm)")
                Text("Min BPM: \(viewModel.minBPM) Max BPM: \(viewModel.maxBPM)")
                Text("Average BPM: \(viewModel.avgBPM)")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            } else {
                Text("Calculating...")
            }
            
            HStack(spacing: 20) {
                Button("Start") { viewModel.startMonitoring() }
                Button("Stop") { viewModel.stopMonitoring() }
            }
        }
        .padding()
        .onAppear { viewModel.requestCameraAccess() }
    }
}



#Preview {
    HeartRateView()
}
