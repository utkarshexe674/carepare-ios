//
//  InitialWelcomeSplashScreen.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct InitialWelcomeSplashScreen: View {
    @ObservedObject var bookingData: BookingFlowData
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            
            VStack(spacing: 28) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.teal.opacity(0.18), Color.clear],
                                center: .center,
                                startRadius: 10,
                                endRadius: 130
                            )
                        )
                        .frame(width: 250, height: 250)
                    
                    CarePareLogoView(size: 104)
                }
                
                VStack(spacing: 8) {
                    Text("CarePare")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("Emergency Pet Care & Doorstep Vets")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    WelcomeFeatureBadge(
                        icon: "bolt.shield.fill",
                        title: "18-Minute Emergency Arrival",
                        subtitle: "Verified veterinary surgeons dispatched directly to your doorstep."
                    )
                    
                    WelcomeFeatureBadge(
                        icon: "cross.case.fill",
                        title: "8+ Health Specialists Available",
                        subtitle: "Canine, feline, avian, and exotic certified pet doctors on-demand."
                    )
                    
                    WelcomeFeatureBadge(
                        icon: "doc.badge.plus",
                        title: "Instant Digital Prescriptions",
                        subtitle: "Review doctor diagnoses, medicine kits, and invoices anytime."
                    )
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                
                Spacer()
                
                NavigationLink(destination: MainDashboardView(bookingData: bookingData)) {
                    HStack(spacing: 10) {
                        Text("Get Started")
                            .fontWeight(.bold)
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            colors: [Color.teal, Color.blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
                    .shadow(color: Color.teal.opacity(0.35), radius: 10, y: 5)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }
}
