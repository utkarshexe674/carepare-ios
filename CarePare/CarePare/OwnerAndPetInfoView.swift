//
//  OwnerAndPetInfoView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct OwnerAndPetInfoView: View {
    @ObservedObject var data: BookingFlowData
    @State private var showMapPicker = false
    
    let ageUnits = ["Months", "Years"]
    let genders = ["Male", "Female"]
    
    var isFormValid: Bool {
        !data.ownerName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !data.ownerPhone.trimmingCharacters(in: .whitespaces).isEmpty &&
        !data.petName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("STEP 1 OF 4").font(.caption).fontWeight(.bold).foregroundColor(.teal)
                    Text("Basic Details").font(.system(size: 30, weight: .bold))
                    Text("Tell us about yourself and your pet so the veterinarian has the full medical profile.")
                        .font(.subheadline).foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Label("Owner Information", systemImage: "person.crop.circle.fill")
                            .font(.headline).foregroundColor(.teal)
                        Spacer()
                        Button(action: {
                            data.ownerName = data.defaultOwnerName
                            data.ownerPhone = data.defaultOwnerPhone
                            data.ownerAddress = data.defaultOwnerAddress
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "bolt.fill")
                                Text("Autofill Saved Profile")
                            }
                            .font(.caption2).fontWeight(.bold).foregroundColor(.white)
                            .padding(.horizontal, 10).padding(.vertical, 6).background(Color.teal).clipShape(Capsule())
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Your Full Name").font(.caption).foregroundColor(.secondary)
                        TextField("e.g. Alex Johnson", text: $data.ownerName)
                            .padding().background(Color(.secondarySystemBackground)).cornerRadius(12)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Phone Number").font(.caption).foregroundColor(.secondary)
                        TextField("+91 98765 43210", text: $data.ownerPhone)
                            .keyboardType(.phonePad)
                            .padding().background(Color(.secondarySystemBackground)).cornerRadius(12)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("House Address").font(.caption).foregroundColor(.secondary)
                        TextField("Flat/House No, Society, Street", text: $data.ownerAddress)
                            .padding().background(Color(.secondarySystemBackground)).cornerRadius(12)
                        
                        Button(action: { showMapPicker = true }) {
                            HStack(spacing: 6) {
                                Image(systemName: "location.fill").font(.caption).foregroundColor(.teal)
                                Text("Select Current Location from Maps").font(.caption).fontWeight(.semibold).foregroundColor(.teal)
                            }
                            .padding(.top, 4)
                        }
                    }
                }
                .padding().background(Color(.systemBackground)).cornerRadius(16).shadow(color: Color.black.opacity(0.04), radius: 6, y: 3)
                
                VStack(alignment: .leading, spacing: 14) {
                    Label("Pet Profile", systemImage: "pawprint.fill").font(.headline).foregroundColor(.teal)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Pet's Name").font(.caption).foregroundColor(.secondary)
                        TextField("e.g. Milo, Bella", text: $data.petName)
                            .padding().background(Color(.secondarySystemBackground)).cornerRadius(12)
                    }
                    
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Age").font(.caption).foregroundColor(.secondary)
                            TextField("e.g. 2", text: $data.petAge)
                                .keyboardType(.numberPad).padding().background(Color(.secondarySystemBackground)).cornerRadius(12)
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Unit").font(.caption).foregroundColor(.secondary)
                            Picker("Unit", selection: $data.petAgeUnit) {
                                ForEach(ageUnits, id: \.self) { Text($0) }
                            }
                            .pickerStyle(.segmented).frame(height: 50)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Gender").font(.caption).foregroundColor(.secondary)
                        Picker("Gender", selection: $data.petGender) {
                            ForEach(genders, id: \.self) { Text($0) }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Toggle(isOn: $data.isNeutered) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Neutered / Spayed?").font(.subheadline).fontWeight(.medium)
                            Text("Helps diagnose hormonal issues").font(.caption2).foregroundColor(.secondary)
                        }
                    }
                }
                .padding().background(Color(.systemBackground)).cornerRadius(16).shadow(color: Color.black.opacity(0.04), radius: 6, y: 3)
                
                NavigationLink(destination: SelectPetView(data: data)) {
                    HStack {
                        Text("Next: Select Pet & Breed")
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding()
                    .background(isFormValid ? Color.teal : Color.gray.opacity(0.5)).cornerRadius(14)
                }
                .disabled(!isFormValid)
            }
            .padding(18)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Pet Registration")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showMapPicker) {
            MapLocationPickerSheet(selectedAddress: $data.ownerAddress)
        }
    }
}
