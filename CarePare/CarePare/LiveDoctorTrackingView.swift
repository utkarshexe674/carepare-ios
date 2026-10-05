import SwiftUI
import MapKit
import Combine

struct LiveDoctorTrackingView: View {
    let doctor: Veterinarian
    @ObservedObject var data: BookingFlowData
    
    @State private var minutesLeft: Int = 18
    @State private var progressStep: Int = 1
    @State private var doctorLocation: CLLocationCoordinate2D
    @State private var visitLogged = false
    
    let userHomeLocation = CLLocationCoordinate2D(latitude: 28.4720, longitude: 77.5020)
    
    init(doctor: Veterinarian, data: BookingFlowData) {
        self.doctor = doctor
        self.data = data
        _doctorLocation = State(initialValue: doctor.coordinate)
    }
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 28.4735, longitude: 77.5030),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    )
    
    let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Map(position: $cameraPosition) {
                    Annotation("Your Home", coordinate: userHomeLocation) {
                        ZStack {
                            Circle().fill(Color.green).frame(width: 40, height: 40).shadow(radius: 4)
                            Image(systemName: "house.fill").foregroundColor(.white).font(.caption)
                        }
                    }
                    
                    Annotation(doctor.name, coordinate: doctorLocation) {
                        ZStack {
                            Circle().fill(Color.teal).frame(width: 44, height: 44).shadow(radius: 5)
                            Image(systemName: "car.fill").foregroundColor(.white).font(.headline)
                        }
                    }
                }
                .frame(height: 280)
                
                HStack(spacing: 6) {
                    Image(systemName: "clock.badge.fill").foregroundColor(.teal)
                    Text(progressStep == 2 ? "ARRIVED" : "ETA: \(minutesLeft) MINS")
                        .font(.caption).fontWeight(.bold).foregroundColor(.teal)
                }
                .padding(.horizontal, 12).padding(.vertical, 8)
                .background(Color(uiColor: .systemBackground).opacity(0.92))
                .cornerRadius(20).shadow(radius: 3).padding(14)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: 14) {
                        AsyncImage(url: URL(string: doctor.photoURL)) { phase in
                            if let img = phase.image {
                                img.resizable().scaledToFill()
                            } else {
                                Image(systemName: "person.crop.circle.fill").resizable().foregroundColor(.teal)
                            }
                        }
                        .frame(width: 52, height: 52).clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(doctor.name).font(.headline)
                            Text(doctor.degree).font(.caption2).foregroundColor(.secondary)
                            Text(doctor.specialty).font(.caption).foregroundColor(.teal).fontWeight(.semibold)
                        }
                        Spacer()
                    }
                    .padding().background(Color(uiColor: .secondarySystemBackground)).cornerRadius(14)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.seal.fill").foregroundColor(.green)
                        Text("Payment Mode:").font(.caption).foregroundColor(.secondary)
                        Text(data.selectedPaymentMethod).font(.caption).fontWeight(.bold).foregroundColor(.primary)
                        Spacer()
                        Text(doctor.fee).font(.subheadline).fontWeight(.bold).foregroundColor(.teal)
                    }
                    .padding(.horizontal, 14).padding(.vertical, 10)
                    .background(Color.green.opacity(0.1)).cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Live Arrival Tracker").font(.headline)
                        
                        HStack(alignment: .top, spacing: 12) {
                            VStack(spacing: 4) {
                                Circle().fill(Color.green).frame(width: 14, height: 14)
                                Rectangle().fill(progressStep >= 1 ? Color.green : Color.gray.opacity(0.3)).frame(width: 2, height: 35)
                                Circle().fill(progressStep >= 1 ? Color.green : Color.gray.opacity(0.3)).frame(width: 14, height: 14)
                                Rectangle().fill(progressStep >= 2 ? Color.green : Color.gray.opacity(0.3)).frame(width: 2, height: 35)
                                Circle().fill(progressStep >= 2 ? Color.green : Color.gray.opacity(0.3)).frame(width: 14, height: 14)
                            }
                            
                            VStack(alignment: .leading, spacing: 20) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Booking Accepted").font(.subheadline).fontWeight(.semibold)
                                    Text("Doctor confirmed visit for \(data.petName)").font(.caption2).foregroundColor(.secondary)
                                }
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Doctor on the Way").font(.subheadline).fontWeight(progressStep >= 1 ? .semibold : .regular)
                                    Text("En route to \(data.ownerAddress.isEmpty ? data.defaultOwnerAddress : data.ownerAddress)").font(.caption2).foregroundColor(.secondary)
                                }
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Arrived at Doorstep").font(.subheadline).fontWeight(progressStep >= 2 ? .semibold : .regular).foregroundColor(progressStep >= 2 ? .green : .secondary)
                                    Text("Doctor will ring the bell with the medical kit").font(.caption2).foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .padding().background(Color(uiColor: .secondarySystemBackground)).cornerRadius(14)
                    
                    Button(action: {
                        if !visitLogged {
                            let behaviorSummary = data.selectedBehaviors.isEmpty ? "Calm" : data.selectedBehaviors.joined(separator: ", ")
                            let newRecord = PastVisitRecord(
                                orderId: "CARE-\(Int.random(in: 1000...9999))",
                                date: "Today",
                                doctorName: doctor.name,
                                specialty: doctor.specialty,
                                petName: data.petName,
                                petBreed: data.petBreed,
                                fee: doctor.fee,
                                status: "Completed",
                                diagnosis: "Examination for \(data.petName). Alertness: \(data.petMoodState). Noted behaviors: \(behaviorSummary). Health focus addressed: \(doctor.healthFocus).",
                                prescription: [
                                    "CalmCare Neuro Drops - 3 drops with water",
                                    "ImmunoBoost Syrup - 5ml daily (7 days)"
                                ],
                                invoiceDetails: "Home Visit Fee: \(doctor.fee) | Payment Method: \(data.selectedPaymentMethod) | Paid Successfully"
                            )
                            data.pastVisits.insert(newRecord, at: 0)
                            visitLogged = true
                        }
                    }) {
                        HStack {
                            Image(systemName: visitLogged ? "checkmark.circle.fill" : "archivebox.circle.fill")
                            Text(visitLogged ? "Saved to Past Checked Vets" : "Complete Visit & Log Prescription")
                        }
                        .font(.subheadline).fontWeight(.semibold).foregroundColor(.white)
                        .frame(maxWidth: .infinity).padding(.vertical, 14).background(visitLogged ? Color.green : Color.teal).cornerRadius(12)
                    }
                    
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "phone.fill")
                                Text("Call Vet")
                            }
                            .font(.subheadline).fontWeight(.semibold).foregroundColor(.white).frame(maxWidth: .infinity).padding(.vertical, 12).background(Color.teal).cornerRadius(12)
                        }
                        
                        Button(action: {
                            if progressStep < 2 {
                                progressStep += 1
                                minutesLeft = max(0, minutesLeft - 6)
                                doctorLocation = CLLocationCoordinate2D(
                                    latitude: doctorLocation.latitude - 0.001,
                                    longitude: doctorLocation.longitude - 0.001
                                )
                            }
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                Text("Move Closer")
                            }
                            .font(.subheadline).fontWeight(.semibold).foregroundColor(.primary).frame(maxWidth: .infinity).padding(.vertical, 12).background(Color(uiColor: .tertiarySystemBackground)).cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(uiColor: .separator), lineWidth: 1))
                        }
                    }
                }
                .padding(18)
            }
        }
        .navigationTitle("Doctor Tracking")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(timer) { _ in
            if minutesLeft > 1 {
                minutesLeft -= 1
                doctorLocation = CLLocationCoordinate2D(
                    latitude: doctorLocation.latitude - 0.0003,
                    longitude: doctorLocation.longitude - 0.0003
                )
            } else if minutesLeft == 1 {
                minutesLeft = 0
                progressStep = 2
            }
        }
    }
}

