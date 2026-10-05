//
//  MainDashboardView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct MainDashboardView: View {
    @ObservedObject var bookingData: BookingFlowData
    @State private var showProfileSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    NavigationLink(destination: HelpAndSupportView()) {
                        HStack(spacing: 5) {
                            Image(systemName: "questionmark.circle.fill")
                            Text("Help")
                        }
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.teal)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.teal.opacity(0.12))
                        .clipShape(Capsule())
                    }
                    
                    Spacer()
                    
                    Button(action: { showProfileSheet = true }) {
                        HStack(spacing: 5) {
                            Image(systemName: "person.crop.circle.fill")
                            Text("My Profile")
                        }
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.teal)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.teal.opacity(0.12))
                        .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                VStack(spacing: 10) {
                    CarePareLogoView(size: 78)
                    
                    VStack(spacing: 3) {
                        Text("CarePare")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        
                        Text("Emergency Pet Care & Doorstep Vets")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 4)
                
                Text("Instant home visits from 8+ specialized veterinary doctors for dogs, cats, birds, and rabbits.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
                
                NavigationLink(destination: PastCheckedVetsView(bookingData: bookingData)) {
                    HStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(Color.teal.opacity(0.15))
                                .frame(width: 44, height: 44)
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.headline)
                                .foregroundColor(.teal)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Past Checked Veterinarians")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("\(bookingData.pastVisits.count) previous visit(s) with Prescriptions & Receipts")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(14)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                }
                .padding(.horizontal, 20)
                
                NavigationLink(destination: OwnerAndPetInfoView(data: bookingData)) {
                    HStack(spacing: 10) {
                        Text("Begin Pet Profile & Booking")
                            .fontWeight(.semibold)
                        Image(systemName: "pawprint.fill")
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
                    .shadow(color: Color.teal.opacity(0.3), radius: 8, y: 4)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showProfileSheet) {
            ParentProfileOnlyModalView(bookingData: bookingData)
        }
    }
}
