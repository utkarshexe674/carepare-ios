//
//  MapLocationPickerSheet.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI
import MapKit

struct MapLocationPickerSheet: View {
    @Binding var selectedAddress: String
    @Environment(\.dismiss) var dismiss
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.4744, longitude: 77.5040),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    Map(coordinateRegion: $region)
                    VStack(spacing: 0) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 38))
                            .foregroundColor(.red)
                            .shadow(radius: 4)
                        Circle()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 8, height: 4)
                    }
                }
                
                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 12) {
                        Image(systemName: "location.north.circle.fill")
                            .font(.title)
                            .foregroundColor(.teal)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Current Location Detected")
                                .font(.headline)
                            Text("Knowledge Park III, Greater Noida, UP")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    
                    Button(action: {
                        selectedAddress = "Flat 402, Tower B, Knowledge Park III, Greater Noida"
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Confirm & Use This Location")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.teal)
                        .cornerRadius(12)
                    }
                }
                .padding(20)
                .background(Color(.systemBackground))
            }
            .navigationTitle("Pick on Map")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
