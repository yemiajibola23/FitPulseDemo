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
            
            // Header
            VStack(spacing: 24) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.red)
                Text("Live Heart Rate")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
            }
            
            // BPM
            ZStack {
                Circle()
                    .stroke(Color.red.opacity(0.8), lineWidth: 10)
                    .scaleEffect(viewModel.isPulsing ? 1.2 : 1.0)
                    .opacity(viewModel.isPulsing ? 0.3 : 0.1)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: viewModel.isPulsing)
                
                Text("\(viewModel.bpm) BPM")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(Color.secondary)
            }
            .frame(width: 180, height: 180)
            
            // Stats
            HStack(spacing: 20) {
                StatCard(title: "Min", value: viewModel.minBPM, icon: "thermometer.low")
                StatCard(title: "Avg", value: viewModel.avgBPM, icon: "waveform.path.ecg")
                StatCard(title: "Max", value: viewModel.maxBPM, icon: "thermometer.high")
            }
            .font(.subheadline)
            .foregroundStyle(Color.primary)
            
            // Controls
            Button(action: {
                viewModel.isMonitoring ? viewModel.stopMonitoring() : viewModel.startMonitoring()
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }) {
                HStack {
                    Image(systemName: viewModel.isMonitoring ? "stop.fill" : "play.fill")
                    Text(viewModel.isMonitoring ? "Stop": "Start")
                }
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(viewModel.isMonitoring ? .red : .green)
                .cornerRadius(20)
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.top)
            }
            
            Spacer()
        }
        .background(Color(.systemBackground).ignoresSafeArea())
        .padding()
        .onAppear { viewModel.requestCameraAccess() }
    }
}


#Preview {
    HeartRateView()
}
