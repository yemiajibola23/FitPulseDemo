//
//  StatCard.swift
//  FitPulseDemo
//
//  Created by Amira Ajibola  on 7/31/25.
//
import SwiftUI

struct StatCard: View {
    let title: String
    let value: Int
    let icon: String
    
    var body: some View {
        VStack(spacing: 4) {
            Label(title, systemImage: icon)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text("\(value)")
                .font(.title3)
                .fontWeight(.medium)
        }
        .frame(width: 60, height: 60)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
