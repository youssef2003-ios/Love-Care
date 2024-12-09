import SwiftUI

struct ContentView: View {
    
    @AppStorage("Onboarding") var isOnboarding: Bool = true
    
    var body: some View {
        
        if isOnboarding {
            Onboarding()
        }else{
            Home()
        }
       
    }
}

#Preview {
    ContentView()
}
