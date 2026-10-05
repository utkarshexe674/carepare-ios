//
//  HelpAndSupportView.swift
//  MyApp
//
//  Created by Utkarsh Mishra on 28/09/26.
//

import SwiftUI

struct HelpAndSupportView: View {
    @State private var showingCallAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.white)
                            .font(.title3)
                        Text("24/7 CarePare Helpline")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    Text("In immediate life-threatening cases (seizures, poisoning, heavy bleeding), tap below to connect with on-duty veterinary dispatch.")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Button(action: { showingCallAlert = true }) {
                        Text("Call Emergency Dispatch: 1800-CARE-PET")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 11)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.red.opacity(0.88))
                .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 14) {
                    Text("Frequently Asked Questions")
                        .font(.headline)
                    
                    HelpFAQRow(
                        question: "How fast will the doctor arrive at my home?",
                        answer: "Depending on your location, verified nearby veterinarians arrive in 18 to 35 minutes with on-spot medical kits."
                    )
                    
                    HelpFAQRow(
                        question: "Can the doctor perform injections & tests at home?",
                        answer: "Yes. All house-visit doctors carry emergency fluid therapy, anti-nausea/antibiotic injections, pain management, and rapid diagnostic kits."
                    )
                    
                    HelpFAQRow(
                        question: "How are medicine prescriptions delivered?",
                        answer: "After the checkup, the vet enters the prescription directly into the app. You can view, reorder, or download the invoice from the 'Past Checked Vets' section."
                    )
                    
                    HelpFAQRow(
                        question: "What if my pet is exotic (Bird or Rabbit)?",
                        answer: "CarePare includes certified Avian and Exotic pet specialists (such as Dr. Priya Verma) trained specifically for birds, rabbits, and small animals."
                    )
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Need help with an ongoing booking?")
                        .font(.headline)
                    Text("Our support team responds in less than 2 minutes.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("Chat with CarePare Support on WhatsApp")
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(Color.green)
                        .cornerRadius(12)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
            }
            .padding(20)
        }
        .navigationTitle("Help & Support")
        .alert("Calling CarePare Dispatch", isPresented: $showingCallAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Call Now") {}
        } message: {
            Text("Connecting you to the nearest 24/7 on-call veterinary emergency center.")
        }
    }
}

struct HelpFAQRow: View {
    let question: String
    let answer: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Button(action: { withAnimation { isExpanded.toggle() } }) {
                HStack {
                    Text(question)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.teal)
                }
            }
            if isExpanded {
                Text(answer)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 2)
            }
            Divider().padding(.top, 4)
        }
    }
}
