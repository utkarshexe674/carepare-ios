//
//  ParentProfileOnlyModalView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct ParentProfileOnlyModalView: View {
    @ObservedObject var bookingData: BookingFlowData
    @Environment(\.dismiss) var dismiss
    @State private var savedAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Pet Parent (Owner) Information")) {
                    HStack {
                        Text("Full Name").foregroundColor(.secondary)
                        Spacer()
                        TextField("Name", text: $bookingData.defaultOwnerName)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Phone").foregroundColor(.secondary)
                        Spacer()
                        TextField("Phone", text: $bookingData.defaultOwnerPhone)
                            .keyboardType(.phonePad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Email").foregroundColor(.secondary)
                        Spacer()
                        TextField("Email", text: $bookingData.defaultOwnerEmail)
                            .keyboardType(.emailAddress)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("Registered Home Address")) {
                    TextField("Enter full address", text: $bookingData.defaultOwnerAddress, axis: .vertical)
                        .lineLimit(2...4)
                }
                
                Section {
                    Button(action: { savedAlert = true }) {
                        HStack {
                            Spacer()
                            Text("Save Account Profile")
                                .fontWeight(.semibold)
                                .foregroundColor(.teal)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Pet Parent Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .alert("Profile Saved", isPresented: $savedAlert) {
                Button("OK", role: .cancel) { dismiss() }
            } message: {
                Text("Your owner details have been updated and are saved for future bookings.")
            }
        }
    }
}
