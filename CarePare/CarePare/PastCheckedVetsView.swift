//
//  PastCheckedVetsView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct PastCheckedVetsView: View {
    @ObservedObject var bookingData: BookingFlowData
    @State private var selectedVisitForDetails: PastVisitRecord? = nil
    
    var body: some View {
        List {
            if bookingData.pastVisits.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("No checked visits yet.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 40)
            } else {
                ForEach(bookingData.pastVisits) { visit in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("ORDER ID: \(visit.orderId)")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(visit.status)
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.12))
                                .clipShape(Capsule())
                        }
                        
                        HStack(alignment: .top, spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color.teal.opacity(0.15))
                                    .frame(width: 44, height: 44)
                                Image(systemName: "cross.case.fill")
                                    .foregroundColor(.teal)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(visit.doctorName).font(.headline)
                                Text(visit.specialty).font(.caption2).foregroundColor(.secondary)
                                Text("Pet: \(visit.petName) (\(visit.petBreed))").font(.caption).foregroundColor(.teal)
                            }
                            Spacer()
                            Text(visit.fee).font(.subheadline).fontWeight(.bold)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Visited: \(visit.date)").font(.caption2).foregroundColor(.secondary)
                            Spacer()
                            Button(action: { selectedVisitForDetails = visit }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "doc.text.fill")
                                    Text("View Rx & Invoice")
                                }
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.teal)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.teal.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .navigationTitle("Past Checked Vets")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedVisitForDetails) { visit in
            PrescriptionInvoiceModalView(visit: visit)
        }
    }
}

struct PrescriptionInvoiceModalView: View {
    let visit: PastVisitRecord
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(visit.orderId).font(.caption).fontWeight(.bold).foregroundColor(.teal)
                            Spacer()
                            Text(visit.date).font(.caption).foregroundColor(.secondary)
                        }
                        Text(visit.doctorName).font(.title2).fontWeight(.bold)
                        Text(visit.specialty).font(.subheadline).foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Doctor's Diagnosis", systemImage: "stethoscope")
                            .font(.headline).foregroundColor(.teal)
                        Text(visit.diagnosis).font(.subheadline).foregroundColor(.primary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Prescribed Medications", systemImage: "pills.fill")
                            .font(.headline).foregroundColor(.teal)
                        ForEach(visit.prescription, id: \.self) { med in
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "checkmark.circle.fill").foregroundColor(.teal).font(.caption).padding(.top, 2)
                                Text(med).font(.subheadline)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Invoice & Payment Summary", systemImage: "creditcard.fill")
                            .font(.headline).foregroundColor(.teal)
                        Text(visit.invoiceDetails).font(.caption).foregroundColor(.secondary)
                        Divider()
                        HStack {
                            Text("Total Paid:").fontWeight(.semibold)
                            Spacer()
                            Text(visit.fee).font(.title3).fontWeight(.bold).foregroundColor(.teal)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
                    
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "arrow.clockwise.circle.fill")
                            Text("Revisit / Book Doctor Again")
                        }
                        .font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.teal).cornerRadius(14)
                    }
                    .padding(.top, 10)
                }
                .padding(20)
            }
            .navigationTitle("Prescription & Invoice")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}
