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
            VStack(spacing: 24) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.red)
                Text("Live Heart Rate")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            // BPM
            Text("\(viewModel.bpm) BPM")
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(.white)
                .scaleEffect(viewModel.isPulsing ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 1.0), value: viewModel.isPulsing)
            
            // Stats
            HStack(spacing: 32) {
                Text("Min: \(viewModel.minBPM)")
                Text("Max: \(viewModel.maxBPM)")
                Text("Avg: \(viewModel.avgBPM)")
            }
            .font(.subheadline)
            .foregroundStyle(.gray)
            
            // Controls
            HStack(spacing: 40) {
                Button("Start") {
                    viewModel.startMonitoring()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Stop") {
                    viewModel.stopMonitoring()
                }
                .buttonStyle(.borderedProminent)
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.footnote)
            }
            
            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .padding()
        .onAppear { viewModel.requestCameraAccess() }
    }
}



#Preview {
    HeartRateView()
}
