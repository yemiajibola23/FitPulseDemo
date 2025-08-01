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
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
            
            Text("\(value)")
                .font(.title3)
                .fontWeight(.medium)
        }
        .frame(width: 60, height: 60)
        .background(.thinMaterial)
        .cornerRadius(12)
    }
}
