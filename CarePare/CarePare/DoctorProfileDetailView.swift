//
//  DoctorProfileDetailView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct DoctorProfileDetailView: View {
    let doctor: Veterinarian
    @ObservedObject var data: BookingFlowData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: doctor.photoURL)) { phase in
                        if let img = phase.image {
                            img.resizable().scaledToFill()
                        } else {
                            Image(systemName: "person.crop.circle.fill").resizable().foregroundColor(.teal)
                        }
                    }
                    .frame(width: 84, height: 84)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.teal, lineWidth: 2.5))
                    .shadow(radius: 4)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 4) {
                            Text(doctor.name).font(.title3).fontWeight(.bold)
                            Image(systemName: "checkmark.seal.fill").foregroundColor(.blue)
                        }
                        Text(doctor.specialty).font(.caption).fontWeight(.semibold).foregroundColor(.teal)
                        Text(doctor.degree).font(.caption2).foregroundColor(.secondary)
                        Text("Reg. No: \(doctor.regNumber)").font(.system(size: 10, weight: .medium, design: .monospaced)).foregroundColor(.secondary).padding(.top, 2)
                    }
                    Spacer()
                }
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(18)
                
                HStack(spacing: 12) {
                    DoctorStatBox(title: "Experience", value: "\(doctor.experienceYears)+ Yrs", icon: "calendar")
                    DoctorStatBox(title: "Rating", value: "\(String(format: "%.1f", doctor.rating)) ★", icon: "star.fill")
                    DoctorStatBox(title: "Reviews", value: "\(doctor.reviewsCount)", icon: "bubble.left.and.bubble.right.fill")
                    DoctorStatBox(title: "Avg ETA", value: "\(doctor.arrivalMinutes) m", icon: "bolt.car.fill")
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Label("Primary Emergency Focus", systemImage: "cross.fill").font(.headline).foregroundColor(.teal)
                    Text(doctor.healthFocus).font(.subheadline).fontWeight(.semibold).foregroundColor(.primary)
                        .padding(.horizontal, 12).padding(.vertical, 8).background(Color.teal.opacity(0.1)).cornerRadius(10)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("About the Doctor").font(.headline)
                    Text(doctor.bio).font(.subheadline).foregroundColor(.secondary).lineSpacing(4)
                }
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 10) {
                    Label("Emergency Procedures Offered at Home", systemImage: "bag.fill").font(.headline).foregroundColor(.teal)
                    ForEach(doctor.proceduresOffered, id: \.self) { procedure in
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.teal).font(.subheadline).padding(.top, 1)
                            Text(procedure).font(.subheadline).foregroundColor(.primary)
                        }
                    }
                }
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Label("Verification & Quality Assurance", systemImage: "shield.checkerboard").font(.headline)
                    Text("• License verified against State Veterinary Council\n• Carries temperature-controlled mobile pharmacology kit\n• Real-time digital prescription dispatch with UPI billing")
                        .font(.caption).foregroundColor(.secondary).lineSpacing(4)
                }
                .padding().background(Color.teal.opacity(0.06)).cornerRadius(14)
                
                VStack(spacing: 12) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Consultation Callout Fee").font(.caption).foregroundColor(.secondary)
                            Text(doctor.fee).font(.title2).fontWeight(.bold).foregroundColor(.teal)
                        }
                        Spacer()
                        Text("ETA: ~\(doctor.arrivalMinutes) mins").font(.subheadline).fontWeight(.semibold).foregroundColor(.green)
                    }
                    
                    NavigationLink(destination: PaymentCheckoutView(doctor: doctor, data: data)) {
                        HStack {
                            Image(systemName: "calendar.badge.clock")
                            Text("Book House Visit with \(doctor.name)")
                        }
                        .font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding(.vertical, 16)
                        .background(Color.teal).cornerRadius(14).shadow(color: Color.teal.opacity(0.35), radius: 8, y: 4)
                    }
                }
                .padding(.top, 10)
            }
            .padding(20)
        }
        .navigationTitle("Doctor Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DoctorStatBox: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.teal)
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Text(title)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity).padding(.vertical, 12).background(Color(.secondarySystemBackground)).cornerRadius(12)
    }
}
