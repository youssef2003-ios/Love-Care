import SwiftUI

struct Home: View {
    
    @AppStorage("Onboarding") var isOnboarding: Bool = false
    @State var isSliding: Bool = false

    let feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 50){
            
            //MARK: - Header
            ZStack{
                
                CircleGroupView(circleGroupColor: .gray)
                
                Image("baby-boy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y: isSliding ? 30 : -30)
                    .frame(width: 300, alignment: .center)
                    .animation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: isSliding)
                
            } // ZStack
            
            
            //MARK: - Center
            Text("Having children just puts the whole world into perspective. Everything else just disappears")
                .padding()
                .font(.title3)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
            
            
            //MARK: - Footer
            
            Button {
                isOnboarding.toggle()
                playSound(soundFile: "success", soundType: "m4a")
                feedback.notificationOccurred(.success)
            } label: {
                
                Text("Restart")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                
                
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            
            
        } // VStack
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                isSliding.toggle()
            }
        }
        
        
    }
}

#Preview {
    Home()
}
