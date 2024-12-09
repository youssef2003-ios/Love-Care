import SwiftUI

struct CircleGroupView: View {
    
    @State var isScaling: Bool = false
    
    var circleGroupColor: Color = .red
    
    var body: some View {
        
        ZStack{
            
            Circle()
                .stroke(circleGroupColor.opacity(0.2), lineWidth: 40)
              
            Circle()
                .stroke(circleGroupColor.opacity(0.2), lineWidth: 80)
                
               
        } // ZStack
        .frame(width: 260, height: 260, alignment: .center)
        .scaleEffect(isScaling ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isScaling)
        .onAppear {
            isScaling.toggle()
        }
    }
}

#Preview {
    CircleGroupView()
}
