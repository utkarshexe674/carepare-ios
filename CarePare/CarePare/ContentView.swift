import SwiftUI

struct ContentView: View {
    @StateObject private var bookingData = BookingFlowData()
    
    var body: some View {
        NavigationStack {
            InitialWelcomeSplashScreen(bookingData: bookingData)
        }
    }
}

#Preview {
    ContentView()
}
