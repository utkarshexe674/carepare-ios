//
//  PaymentCheckoutView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct PaymentCheckoutView: View {
    let doctor: Veterinarian
    @ObservedObject var data: BookingFlowData
    @State private var selectedMethod: String = "UPI"
    @State private var selectedUPIApp: String = "Google Pay"
    
    let upiApps = ["Google Pay", "PhonePe", "Paytm", "Any UPI ID"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Booking Summary").font(.headline)
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: doctor.photoURL)) { phase in
                            if let img = phase.image {
                                img.resizable().scaledToFill()
                            } else {
                                Image(systemName: "person.crop.circle.fill").resizable().foregroundColor(.teal)
                            }
                        }
                        .frame(width: 48, height: 48).clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(doctor.name).font(.subheadline).fontWeight(.bold)
                            Text(doctor.specialty).font(.caption2).foregroundColor(.teal)
                            Text("Patient: \(data.petName) (\(data.petBreed))").font(.caption2).foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Image(systemName: "mappin.and.ellipse").foregroundColor(.teal)
                        Text(data.ownerAddress.isEmpty ? data.defaultOwnerAddress : data.ownerAddress).font(.caption).foregroundColor(.secondary).lineLimit(2)
                    }
                }
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Select Payment Method").font(.headline)
                    Button(action: { selectedMethod = "UPI" }) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "bolt.fill").foregroundColor(.teal).font(.title3)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Pay Online via UPI").font(.subheadline).fontWeight(.bold).foregroundColor(.primary)
                                    Text("Instant payment via Google Pay, PhonePe, Paytm").font(.caption2).foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: selectedMethod == "UPI" ? "largecircle.fill.circle" : "circle").foregroundColor(selectedMethod == "UPI" ? .teal : .secondary)
                            }
                            
                            if selectedMethod == "UPI" {
                                Divider()
                                HStack(spacing: 8) {
                                    ForEach(upiApps, id: \.self) { app in
                                        Button(action: { selectedUPIApp = app }) {
                                            Text(app).font(.caption2).fontWeight(.medium).padding(.horizontal, 10).padding(.vertical, 6)
                                                .background(selectedUPIApp == app ? Color.teal.opacity(0.15) : Color(.tertiarySystemBackground))
                                                .foregroundColor(selectedUPIApp == app ? .teal : .secondary).cornerRadius(8)
                                        }
                                    }
                                }
                            }
                        }
                        .padding().background(Color(.systemBackground)).cornerRadius(14)
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(selectedMethod == "UPI" ? Color.teal : Color.clear, lineWidth: 2))
                        .shadow(color: Color.black.opacity(0.03), radius: 5, y: 2)
                    }
                    
                    Button(action: { selectedMethod = "Cash" }) {
                        HStack {
                            Image(systemName: "banknote.fill").foregroundColor(.green).font(.title3)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Pay Cash after Visit").font(.subheadline).fontWeight(.bold).foregroundColor(.primary)
                                Text("Hand over the fee directly to the doctor upon arrival").font(.caption2).foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: selectedMethod == "Cash" ? "largecircle.fill.circle" : "circle").foregroundColor(selectedMethod == "Cash" ? .teal : .secondary)
                        }
                        .padding().background(Color(.systemBackground)).cornerRadius(14)
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(selectedMethod == "Cash" ? Color.teal : Color.clear, lineWidth: 2))
                        .shadow(color: Color.black.opacity(0.03), radius: 5, y: 2)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Payment Breakdown").font(.headline)
                    HStack {
                        Text("Doctor Consultation Fee").font(.subheadline).foregroundColor(.secondary)
                        Spacer()
                        Text(doctor.fee).font(.subheadline)
                    }
                    HStack {
                        Text("Doorstep Travel & Conveyance").font(.subheadline).foregroundColor(.secondary)
                        Spacer()
                        Text("Free").font(.subheadline).foregroundColor(.green)
                    }
                    HStack {
                        Text("Emergency Dispatch Surcharge").font(.subheadline).foregroundColor(.secondary)
                        Spacer()
                        Text("₹0").font(.subheadline)
                    }
                    Divider()
                    HStack {
                        Text("Total Amount to Pay").font(.headline).fontWeight(.bold)
                        Spacer()
                        Text(doctor.fee).font(.title3).fontWeight(.bold).foregroundColor(.teal)
                    }
                }
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(16)
                
                NavigationLink(destination: LiveDoctorTrackingView(doctor: doctor, data: data)) {
                    HStack {
                        Image(systemName: selectedMethod == "UPI" ? "bolt.fill" : "checkmark.seal.fill")
                        Text(selectedMethod == "UPI" ? "Pay \(doctor.fee) via \(selectedUPIApp)" : "Confirm Booking • Pay \(doctor.fee) in Cash")
                    }
                    .font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding(.vertical, 16)
                    .background(Color.teal).cornerRadius(14).shadow(color: Color.teal.opacity(0.35), radius: 8, y: 4)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    data.selectedPaymentMethod = selectedMethod == "UPI" ? "UPI (\(selectedUPIApp))" : "Cash on Visit"
                })
                .padding(.top, 10)
            }
            .padding(20)
        }
        .navigationTitle("Payment Checkout")
        .navigationBarTitleDisplayMode(.inline)
    }
}
