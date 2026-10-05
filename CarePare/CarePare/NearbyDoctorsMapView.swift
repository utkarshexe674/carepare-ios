//
//  NearbyDoctorsMapView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI
import MapKit

struct NearbyDoctorsMapView: View {
    @ObservedObject var data: BookingFlowData
    
    let doctors: [Veterinarian] = [
        Veterinarian(
            name: "Dr. Sarah Chen",
            degree: "BVSc & AH, MVSc (Surgery)",
            specialty: "Critical Care & Emergency Surgeon",
            healthFocus: "Trauma, Acute Vomiting, Wound Care",
            rating: 4.9,
            reviewsCount: 142,
            fee: "₹1,800",
            arrivalMinutes: 18,
            photoURL: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&q=80",
            coordinate: CLLocationCoordinate2D(latitude: 28.4795, longitude: 77.4985),
            experienceYears: 11,
            regNumber: "VCI/UP/2015/09841",
            bio: "Former Chief Resident of Emergency Surgery at Metro Veterinary Referral. Specializes in emergency fluid stabilization, point-of-care ultrasound, gastrointestinal emergencies, and acute trauma resuscitation.",
            proceduresOffered: [
                "Emergency Gastric Decompression",
                "Point-of-Care Ultrasound (POCUS)",
                "Wound Debridement & Suturing",
                "Intravenous Fluid & Blood Product Protocol"
            ]
        ),
        Veterinarian(
            name: "Dr. David Miller",
            degree: "DVM, Internal Canine & Feline Medicine",
            specialty: "Infectious Diseases & Fever Specialist",
            healthFocus: "High Fever, Lethargy, Dehydration",
            rating: 4.8,
            reviewsCount: 118,
            fee: "₹1,500",
            arrivalMinutes: 22,
            photoURL: "https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400&q=80",
            coordinate: CLLocationCoordinate2D(latitude: 28.4635, longitude: 77.5140),
            experienceYears: 9,
            regNumber: "VCI/DL/2017/04512",
            bio: "Board-certified internal medicine consultant focusing on tick-borne fever, parvovirus supportive care, acute pancreatitis, and metabolic disorders in small animals.",
            proceduresOffered: [
                "Rapid Parvo & Distemper Antigen Kits",
                "Electrolyte & Hydration Resuscitation",
                "Therapeutic Anti-emetic Protocols",
                "Spot Blood Glucose & Lactate Checks"
            ]
        ),
        Veterinarian(
            name: "Dr. Priya Verma",
            degree: "BVSc, Certified Avian & Exotic Specialist",
            specialty: "Avian, Reptile & Exotic Small Pets",
            healthFocus: "Birds, Rabbits, Guinea Pigs, Hamsters",
            rating: 4.9,
            reviewsCount: 96,
            fee: "₹1,600",
            arrivalMinutes: 26,
            photoURL: "https://images.unsplash.com/photo-1594824813633-879e6005b821?w=400&q=80",
            coordinate: CLLocationCoordinate2D(latitude: 28.4860, longitude: 77.5125),
            experienceYears: 8,
            regNumber: "VCI/UP/2018/11290",
            bio: "Internationally trained avian and exotic species veterinarian. Expert in critical rabbit gut stasis, crop impaction in parrots, beak/nail trauma, and respiratory distress in non-traditional companion pets.",
            proceduresOffered: [
                "Rabbit GI Stasis Emergency Injections",
                "Avian Crop Lavage & Feeding Tube",
                "Small Mammal Micro-dosing Protocols",
                "Safe Oxygen Tent Chamber Delivery"
            ]
        ),
        Veterinarian(
            name: "Dr. Rohan Kapoor",
            degree: "MVSc (Veterinary Neurology & Behavior)",
            specialty: "Pet Neurologist & Behavioral Care",
            healthFocus: "Seizures, Tremors, Loss of Balance, Panic",
            rating: 4.7,
            reviewsCount: 84,
            fee: "₹1,900",
            arrivalMinutes: 25,
            photoURL: "https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=400&q=80",
            coordinate: CLLocationCoordinate2D(latitude: 28.4610, longitude: 77.4915),
            experienceYears: 13,
            regNumber: "VCI/HR/2013/02198",
            bio: "Dedicated neurologist with over a decade managing idiopathic epilepsy, vestibulo-cochlear ataxia, acute spinal compression, and canine separation panic states.",
            proceduresOffered: [
                "Cluster Seizure Abatement Protocol",
                "Cranial & Spinal Reflex Evaluation",
                "Neuro-sedative Anxiolytic Regimens",
                "Acute Vestibular Syndrome Stabilization"
            ]
        ),
        Veterinarian(
            name: "Dr. Ananya Iyer",
            degree: "BVSc, MVSc (Dermatology)",
            specialty: "Veterinary Dermatologist & Allergist",
            healthFocus: "Skin Allergies, Rashes, Ear Infections",
            rating: 4.8,
            reviewsCount: 110,
            fee: "₹1,400",
            arrivalMinutes: 20,
            photoURL: "https://images.unsplash.com/photo-1614608682850-e0d6ed316d47?w=400&q=80",
            coordinate: CLLocationCoordinate2D(latitude: 28.4715, longitude: 77.5195),
            experienceYears: 7,
            regNumber: "VCI/UP/2019/08123",
            bio: "Clinical skin and allergy physician with specialized focus on acute hot spots, severe flea allergy dermatitis, deep otitis externa, and atopic immunosuppressive therapy.",
            proceduresOffered: [
                "Deep Ear Flush & Otoscopic Evaluation",
                "Skin Scraping & In-hand Cytology",
                "Intradermal Anti-pruritic Biologicals",
                "Secondary Pyoderma Antibiotic Plan"
            ]
        ),
        Veterinarian(
            name: "Dr. Vikram Sethi",
            degree: "DVM, Veterinary Orthopedics",
            specialty: "Bone & Joint Mobility Surgeon",
            healthFocus: "Limping, Hip Dysplasia, Fractures",
            rating: 4.9,
            reviewsCount: 130,
            fee: "₹2,000",
            arrivalMinutes: 28,
            photoURL: "https://images.unsplash.com/photo-1622902046580-2b47f47f5471?w=400&q=80",
            coordinate: CLLocationCoordinate2D(latitude: 28.4910, longitude: 77.5020),
            experienceYears: 15,
            regNumber: "VCI/PB/2011/01004",
            bio: "Senior orthopedic consultant and trauma surgeon. Manages anterior cruciate ligament (ACL) strains, acute patellar luxations, joint immobilizations, and multimodal pain therapy.",
            proceduresOffered: [
                "Temporary Limb Splinting & Robert Jones Cast",
                "Joint Palpation & Ortolani Maneuver",
                "Targeted Analgesic & Nerve Block Protocol",
                "Post-Trauma Mobility Rehabilitation"
            ]
        ),
        Veterinarian(
            name: "Dr. Neha Kulkarni",
            degree: "BVSc, Feline Medicine Specialist",
            specialty: "Cat Internal Medicine & Gastro Care",
            healthFocus: "Feline Kidney/Liver, Urinary Issues, Vomiting",
            rating: 4.8,
            reviewsCount: 104,
            fee: "₹1,500",
            arrivalMinutes: 24,
            photoURL: "https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=400&q=80",
            coordinate: CLLocationCoordinate2D(latitude: 28.4735, longitude: 77.4855),
            experienceYears: 10,
            regNumber: "VCI/MH/2016/05478",
            bio: "Cat-friendly certified veterinary practitioner. Specialized in managing feline lower urinary tract disease (FLUTD), chronic renal insufficiency flare-ups, and hepatic lipidosis.",
            proceduresOffered: [
                "Cat Urinary Bladder Palpation & Relief",
                "Subcutaneous Fluid Therapy Demonstration",
                "Low-Stress Feline Gentle Handling",
                "Renal & Hepatic Supportive Injections"
            ]
        ),
        Veterinarian(
            name: "Dr. Arjun Mehra",
            degree: "MVSc (Veterinary Toxicology & Critical Care)",
            specialty: "Toxicology & Intensive Care Vet",
            healthFocus: "Poison Ingestion, Severe Respiratory Distress",
            rating: 4.9,
            reviewsCount: 156,
            fee: "₹2,100",
            arrivalMinutes: 16,
            photoURL: "https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=400&q=80",
            coordinate: CLLocationCoordinate2D(latitude: 28.4550, longitude: 77.5050),
            experienceYears: 14,
            regNumber: "VCI/DL/2012/03219",
            bio: "Toxicology specialist and ICU clinician. Manages ingestion of human medications, chocolate, rat poison (anticoagulants), toxic lilies, as well as acute respiratory distress syndrome.",
            proceduresOffered: [
                "Rapid Toxicology Counteractive Protocols",
                "Activated Charcoal Toxin Adsorption",
                "Upper Airway Emergency Nebulization",
                "Hemodynamic Shock Reversal Therapy"
            ]
        )
    ]
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 28.4730, longitude: 77.5035),
            span: MKCoordinateSpan(latitudeDelta: 0.052, longitudeDelta: 0.052)
        )
    )
    
    var body: some View {
        VStack(spacing: 0) {
            Map(position: $cameraPosition) {
                Annotation("Your Home", coordinate: CLLocationCoordinate2D(latitude: 28.4720, longitude: 77.5020)) {
                    ZStack {
                        Circle().fill(Color.green).frame(width: 34, height: 34).shadow(radius: 3)
                        Image(systemName: "house.fill").foregroundColor(.white).font(.caption2)
                    }
                }
                
                ForEach(doctors) { doc in
                    Annotation(doc.name, coordinate: doc.coordinate) {
                        ZStack {
                            Circle().fill(Color.teal).frame(width: 36, height: 36).shadow(radius: 4)
                            Image(systemName: "cross.case.fill").foregroundColor(.white).font(.footnote)
                        }
                    }
                }
            }
            .frame(height: 230)
            
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Matched Specialists for \(data.petName)").font(.headline)
                            Text("Tap any card to view full credentials & procedures").font(.caption2).foregroundColor(.teal).fontWeight(.semibold)
                        }
                        Spacer()
                    }
                    .padding(.horizontal).padding(.top, 10)
                    
                    ForEach(doctors) { doc in
                        VetProfileCard(vet: doc, data: data)
                    }
                }
                .padding(.bottom, 20)
            }
            .background(Color(.systemGroupedBackground))
        }
        .navigationTitle("CarePare Doctors")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VetProfileCard: View {
    let vet: Veterinarian
    @ObservedObject var data: BookingFlowData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            NavigationLink(destination: DoctorProfileDetailView(doctor: vet, data: data)) {
                HStack(alignment: .center, spacing: 14) {
                    AsyncImage(url: URL(string: vet.photoURL)) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().scaledToFill()
                        case .failure, .empty:
                            ZStack {
                                Circle().fill(Color.teal.opacity(0.15))
                                Image(systemName: "person.crop.circle.fill").resizable().foregroundColor(.teal).padding(4)
                            }
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.teal.opacity(0.3), lineWidth: 2))
                    .shadow(color: Color.black.opacity(0.08), radius: 4, y: 2)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        HStack(spacing: 4) {
                            Text(vet.name).font(.headline).fontWeight(.bold).foregroundColor(.primary)
                            Image(systemName: "checkmark.seal.fill").foregroundColor(.blue).font(.caption)
                        }
                        Text(vet.specialty).font(.caption).fontWeight(.semibold).foregroundColor(.teal)
                        Text(vet.degree).font(.caption2).foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        HStack(spacing: 3) {
                            Image(systemName: "star.fill").foregroundColor(.yellow).font(.caption)
                            Text(String(format: "%.1f", vet.rating)).font(.subheadline).fontWeight(.bold).foregroundColor(.primary)
                        }
                        Text("(\(vet.reviewsCount))").font(.caption2).foregroundColor(.secondary)
                        Image(systemName: "chevron.right").font(.caption2).foregroundColor(.secondary).padding(.top, 4)
                    }
                }
            }
            
            HStack(spacing: 6) {
                Image(systemName: "cross.fill").font(.caption2).foregroundColor(.teal)
                Text("Health Focus: \(vet.healthFocus)").font(.caption2).fontWeight(.medium).foregroundColor(.primary)
            }
            .padding(.horizontal, 10).padding(.vertical, 5).background(Color.teal.opacity(0.08)).cornerRadius(8)
            
            Divider()
            
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "bolt.car.fill").foregroundColor(.green)
                    VStack(alignment: .leading, spacing: 1) {
                        Text("ETA").font(.caption2).foregroundColor(.secondary)
                        Text("\(vet.arrivalMinutes) mins").font(.subheadline).fontWeight(.bold).foregroundColor(.green)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 1) {
                    Text("Home Visit Fee").font(.caption2).foregroundColor(.secondary)
                    Text(vet.fee).font(.subheadline).fontWeight(.bold).foregroundColor(.primary)
                }
            }
            
            NavigationLink(destination: PaymentCheckoutView(doctor: vet, data: data)) {
                Text("Proceed to Checkout & Book Visit")
                    .font(.subheadline).fontWeight(.semibold).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding(.vertical, 12).background(Color.teal).cornerRadius(12)
            }
            .padding(.top, 2)
        }
        .padding(16).background(Color(.systemBackground)).cornerRadius(18)
        .shadow(color: Color.black.opacity(0.04), radius: 5, y: 2).padding(.horizontal, 16)
    }
}
