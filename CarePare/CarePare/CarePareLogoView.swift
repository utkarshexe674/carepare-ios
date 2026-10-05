//
//  CarePareLogoView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct CarePareLogoView: View {
    var size: CGFloat = 88
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.05, green: 0.65, blue: 0.68),
                            Color(red: 0.08, green: 0.45, blue: 0.75)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.22), lineWidth: 1.5)
                )
                .shadow(color: Color.teal.opacity(0.3), radius: size * 0.14, y: size * 0.08)
            
            ZStack {
                Image(systemName: "pawprint.fill")
                    .font(.system(size: size * 0.48, weight: .semibold))
                    .foregroundStyle(.white)
                
                Image(systemName: "cross.fill")
                    .font(.system(size: size * 0.16, weight: .bold))
                    .foregroundStyle(Color(red: 0.05, green: 0.55, blue: 0.65))
                    .offset(y: size * 0.04)
            }
        }
    }
}

struct WelcomeFeatureBadge: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.teal.opacity(0.12))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(.teal)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
