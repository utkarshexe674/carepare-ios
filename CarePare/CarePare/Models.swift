import SwiftUI
import MapKit
import Combine

struct PetCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let breeds: [String]
}

struct Veterinarian: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let degree: String
    let specialty: String
    let healthFocus: String
    let rating: Double
    let reviewsCount: Int
    let fee: String
    let arrivalMinutes: Int
    let photoURL: String
    let coordinate: CLLocationCoordinate2D
    let experienceYears: Int
    let regNumber: String
    let bio: String
    let proceduresOffered: [String]
    
    static func == (lhs: Veterinarian, rhs: Veterinarian) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

struct PastVisitRecord: Identifiable {
    let id = UUID()
    let orderId: String
    let date: String
    let doctorName: String
    let specialty: String
    let petName: String
    let petBreed: String
    let fee: String
    let status: String
    let diagnosis: String
    let prescription: [String]
    let invoiceDetails: String
}

class BookingFlowData: ObservableObject {
    @Published var defaultOwnerName: String = "Alex Johnson"
    @Published var defaultOwnerPhone: String = "+91 98765 43210"
    @Published var defaultOwnerAddress: String = "Flat 402, Knowledge Park III, Greater Noida"
    @Published var defaultOwnerEmail: String = "alex.johnson@example.com"
    
    @Published var ownerName: String = ""
    @Published var ownerPhone: String = ""
    @Published var ownerAddress: String = ""
    
    @Published var petName: String = "Milo"
    @Published var petAge: String = "2"
    @Published var petAgeUnit: String = "Years"
    @Published var petGender: String = "Male"
    @Published var isNeutered: Bool = true
    
    @Published var petType: String = "Dog"
    @Published var petBreed: String = "Golden Retriever"
    
    @Published var selectedBehaviors: Set<String> = ["Restless / Pacing"]
    @Published var petMoodState: String = "Dull / Depressed"
    
    @Published var selectedPaymentMethod: String = "UPI Instant (GPay / PhonePe / Paytm)"
    
    @Published var pastVisits: [PastVisitRecord] = [
        PastVisitRecord(
            orderId: "CARE-8821",
            date: "18 Sep 2026",
            doctorName: "Dr. Sarah Chen",
            specialty: "Critical Care & Emergency Surgeon",
            petName: "Milo",
            petBreed: "Golden Retriever",
            fee: "₹1,800",
            status: "Completed",
            diagnosis: "Acute Gastroenteritis. Mild dehydration treated with on-spot electrolytes.",
            prescription: [
                "GastroSoft Suspension - 5ml twice daily (5 days)",
                "Probiotic Chewables - 1 tab after meals",
                "Electrolyte Hydration Sachet - mix in drinking water"
            ],
            invoiceDetails: "Home Consultation: ₹1,200 | Medication Kit: ₹400 | Conveyance: ₹200 | Paid via UPI"
        )
    ]
}

