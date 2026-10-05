# CarePare — On-Demand & Emergency Doorstep Veterinary Platform

CarePare is an enterprise-grade native iOS application developed in **SwiftUI**, **MapKit**, and **Combine**. The platform connects pet owners with board-certified veterinary doctors and emergency surgeons for on-demand home visits, rapid diagnostic triage, real-time dispatch, and end-to-end digital medical record (EMR) management.

---

## 👥 Engineering Team & Technical Leadership

* **Project Mentor / Technical Director**: **Anjali Srivastava**

| Engineer | Identifier | Core Domain | Technical Ownership |
| :--- | :--- | :--- | :--- |
| **Khushi** | `2502221530091` | **UI/UX & Frontend Architecture** | • Native SwiftUI component library, design tokens, and branding assets (`CarePareLogoView`)<br>• Multi-stage customer onboarding and booking funnel views (`OwnerAndPetInfoView`, `SelectPetView`)<br>• Modal presentation layers (`BreedPickerSheet`, `PrescriptionInvoiceModalView`)<br>• Dynamic Type, dark mode compliance, and responsive layouts across iOS form factors |
| **Utkarsh** | `2502221530197` | **Backend, Geospatial & API Systems** | • MapKit geospatial query integration and dynamic coordinate mapping for local clinics<br>• Service layer abstraction for 8 medical specializations and operational metadata<br>• Telephony subsystem bridge (`1800-CARE-PET` emergency dispatch integration)<br>• Data serialization contracts for prescriptions, medication regimes, and invoice structures |
| **Navneet** | `2502221530127` | **State Management & Domain Architecture** | • Reactive state engine built with `BookingFlowData: ObservableObject`<br>• Core domain models (`PetCategory`, `Veterinarian`, `PastVisitRecord`)<br>• Triage business logic, urgency filtering, and behavioral/symptom state machine<br>• Client profile caching, account autofill, and persistence orchestration |
| **Kriti** | `2502221530100` | **DevOps, Quality Assurance & Release** | • Target build schemes, signing identities, provisioning profiles, and entitlements<br>• Test automation pipeline: unit tests for state transitions and XCUITest UI regressions<br>• iOS permission management (`NSLocationWhenInUseUsageDescription`, telephony)<br>• CI/CD pipeline automation and TestFlight / App Store deployment management |

---

## 🏛️ System Architecture

The application adopts the **MVVM (Model-View-ViewModel)** architectural pattern, leveraging Apple's `Combine` framework for deterministic, unidirectional data flow.

```text
┌────────────────────────────────────────────────────────────────────────┐
│                           PRESENTATION LAYER                           │
│                                                                        │
│   ContentView ────────► InitialWelcomeSplashScreen ──► MainDashboard   │
│        │                                                      │        │
│        ▼                                                      ▼        │
│   OwnerAndPetInfoView ──► SelectPetView ──► DescribeIssueView         │
│        │                                           │                   │
│        ▼                                           ▼                   │
│   MapLocationPickerSheet                  NearbyDoctorsMapView         │
│                                                    │                   │
│                                                    ▼                   │
│                                           PastCheckedVetsView          │
│                                                    │                   │
│                                                    ▼                   │
│                                       PrescriptionInvoiceModalView     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                       Bi-directional State Binding
                      (@ObservedObject / @Published)
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│                        REACTIVE STATE & LOGIC                          │
│                                                                        │
│                         BookingFlowData                                │
│   • Identity & Context : User profile, contact, registered geocoords   │
│   • Booking Pipeline   : Active patient attributes, breed resolution   │
│   • Clinical Triage    : Symptom bitmask, behavioral logs, urgency     │
│   • Records Management : Order histories, medical Rx, billing caches   │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                            Immutable Projections
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│                             DOMAIN LAYER                               │
│                                                                        │
│   • PetCategory       : Taxonomy metadata and breed registries         │
│   • Veterinarian      : Council certifications (VCI), skills, arrival  │
│   • PastVisitRecord   : Clinical EMR, diagnostics, financial invoices  │
└────────────────────────────────────────────────────────────────────────┘