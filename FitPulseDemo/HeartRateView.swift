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
            ZStack {
                Circle()
                    .stroke(Color.red.opacity(0.6), lineWidth: 8)
                    .scaleEffect(viewModel.isPulsing ? 1.2 : 1.0)
                    .opacity(viewModel.isPulsing ? 0.3 : 0.1)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: viewModel.isPulsing)
                
                Text("\(viewModel.bpm) BPM")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(width: 180, height: 180)
            
            // Stats
            HStack(spacing: 20) {
                StatCard(title: "Min", value: viewModel.minBPM)
                StatCard(title: "Avg", value: viewModel.avgBPM)
                StatCard(title: "Max", value: viewModel.maxBPM)
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
