//
//  DescribeIssueView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct DescribeIssueView: View {
    @ObservedObject var data: BookingFlowData
    
    @State private var issueNotes: String = ""
    @State private var selectedUrgency: String = "Moderate"
    @State private var selectedSymptoms: Set<String> = []
    @State private var hasAttachedPhoto: Bool = false
    
    let symptomsList = [
        "Vomiting", "Not Eating", "Lethargic", "Limping / Pain",
        "Diarrhea", "High Fever", "Breathing Trouble", "Skin Rash"
    ]
    let urgencyLevels = ["Mild", "Moderate", "Emergency"]
    
    let behaviorOptions = [
        "Restless / Pacing", "Excessive Whining", "Hiding in Corners",
        "Aggressive When Touched", "Shaking / Shivering", "Unusually Clingy", "Loss of Balance"
    ]
    let moodStates = ["Normal", "Dull / Depressed", "Disoriented", "Unresponsive"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.teal.opacity(0.15)).frame(width: 44, height: 44)
                        Image(systemName: "cross.case.fill").foregroundColor(.teal)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(data.petName) • \(data.petBreed)").font(.headline)
                        Text("\(data.petGender), \(data.petAge) \(data.petAgeUnit) old • Owner: \(data.ownerName.isEmpty ? data.defaultOwnerName : data.ownerName)")
                            .font(.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding().background(Color(.secondarySystemBackground)).cornerRadius(14)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Condition Urgency").font(.headline)
                    HStack(spacing: 10) {
                        ForEach(urgencyLevels, id: \.self) { level in
                            let isPicked = selectedUrgency == level
                            Button(action: { selectedUrgency = level }) {
                                Text(level).font(.subheadline).fontWeight(.medium).frame(maxWidth: .infinity).padding(.vertical, 10)
                                    .background(isPicked ? (level == "Emergency" ? Color.red : Color.teal) : Color(.secondarySystemBackground))
                                    .foregroundColor(isPicked ? .white : .primary).cornerRadius(10)
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Physical Symptoms").font(.headline)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))], spacing: 8) {
                        ForEach(symptomsList, id: \.self) { sym in
                            let isPicked = selectedSymptoms.contains(sym)
                            Button(action: {
                                if isPicked { selectedSymptoms.remove(sym) } else { selectedSymptoms.insert(sym) }
                            }) {
                                Text(sym).font(.caption).fontWeight(.medium).padding(.horizontal, 12).padding(.vertical, 8)
                                    .background(isPicked ? Color.teal.opacity(0.15) : Color(.secondarySystemBackground))
                                    .foregroundColor(isPicked ? .teal : .primary).clipShape(Capsule())
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Label("Pet Behavior & Mood Changes", systemImage: "brain.head.profile").font(.headline).foregroundColor(.teal)
                    Text("How is your pet acting differently than usual?").font(.caption).foregroundColor(.secondary)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))], spacing: 8) {
                        ForEach(behaviorOptions, id: \.self) { beh in
                            let isPicked = data.selectedBehaviors.contains(beh)
                            Button(action: {
                                if isPicked { data.selectedBehaviors.remove(beh) } else { data.selectedBehaviors.insert(beh) }
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: isPicked ? "checkmark" : "plus").font(.caption2)
                                    Text(beh).font(.caption).fontWeight(.medium)
                                }
                                .padding(.horizontal, 10).padding(.vertical, 8)
                                .background(isPicked ? Color.blue.opacity(0.15) : Color(.secondarySystemBackground))
                                .foregroundColor(isPicked ? .blue : .primary).clipShape(Capsule())
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Current Alertness / Mood:").font(.caption).foregroundColor(.secondary)
                        Picker("Alertness", selection: $data.petMoodState) {
                            ForEach(moodStates, id: \.self) { Text($0) }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.top, 4)
                }
                .padding().background(Color(.systemBackground)).cornerRadius(16).shadow(color: Color.black.opacity(0.03), radius: 5, y: 2)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Additional Notes").font(.headline)
                    TextEditor(text: $issueNotes).frame(height: 80).padding(8).background(Color(.secondarySystemBackground)).cornerRadius(12)
                }
                
                Button(action: { hasAttachedPhoto.toggle() }) {
                    HStack(spacing: 12) {
                        Image(systemName: hasAttachedPhoto ? "checkmark.circle.fill" : "camera.fill").font(.title2).foregroundColor(hasAttachedPhoto ? .green : .teal)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(hasAttachedPhoto ? "Photo Attached (symptom_preview.jpg)" : "Upload Photo / Video").font(.subheadline).fontWeight(.medium).foregroundColor(.primary)
                            Text(hasAttachedPhoto ? "Tap to remove" : "Helps doctor bring correct medication").font(.caption2).foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding().background(Color(.secondarySystemBackground)).cornerRadius(14)
                }
                
                NavigationLink(destination: NearbyDoctorsMapView(data: data)) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Find Nearby Specialists (8 Available)")
                    }
                    .font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.teal).cornerRadius(14)
                }
                .padding(.top, 10)
            }
            .padding(18)
        }
        .navigationTitle("Symptoms & Behavior")
        .navigationBarTitleDisplayMode(.inline)
    }
}
