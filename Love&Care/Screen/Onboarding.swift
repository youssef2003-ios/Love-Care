import SwiftUI

struct Onboarding: View {
    //Properties
    
    @AppStorage("Onboarding") var isOnboarding: Bool = true
    @State var isScaling: Bool = false
    @State var isSliding: Bool = false
    @State var imageOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    @State var buttonOffset: CGFloat = 0.0
    @State var buttonWidth: Double = UIScreen.main.bounds.width - 80
    
    let feedback = UINotificationFeedbackGenerator()
    
    //Body
    var body: some View {
        
        ZStack{
            
            Color("ColorBlue")
                .ignoresSafeArea(.all)
            
            VStack{
                
                //MARK: - Header
                VStack{
                    
                    Text(abs(imageOffset.width)>0 ?  "Care." : "Love")
                        .foregroundStyle(.white)
                        .font(.system(size: 60, weight: .heavy))
                    
                    Text("Life doesn't come with a manua, it comes with a mother")
                        .foregroundStyle(.white)
                        .fontWeight(.light)
                        .font(.title3)
                        .padding(.horizontal, 10)
                        .multilineTextAlignment(.center)
                    
                } // VStack
                .offset(y: isSliding ? 0 : -40)
                .animation(.easeInOut(duration: 1), value: isSliding)
                Spacer()
                
                //MARK: - Center
                
                ZStack{
                    
                    
                    CircleGroupView(circleGroupColor: .white)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width)/5, opaque: false)
                    
                    Image("happy-pregnant")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: imageOffset.width, y: 0)
                        .rotationEffect(.degrees(imageOffset.width / 15))
                        .scaleEffect(isScaling ? 1 : 0.8)
                        .animation(.easeOut(duration: 0.5), value: isScaling)
                        .shadow(radius: 8, x: 3 , y: 30)
                        .overlay(
                            Image(systemName: "arrow.left.and.right.circle")
                                .font(.system(size: 40, weight: .ultraLight, design: .rounded))
                                .foregroundStyle(.white)
                                .opacity(abs(imageOffset.width)>0 ? 0 : 1)
                            ,alignment: .bottom
                        )
                        .frame(width: 300, alignment: .center)
                        .gesture(DragGesture()
                            .onChanged({ gesture in
                                
                                if abs(gesture.translation.width) <= 150 {
                                    imageOffset = gesture.translation
                                }
                            })
                                 
                                .onEnded({ _ in
                                    
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        
                                        imageOffset = .zero
                                    }
                                })
                                 
                        ) // gesture
                    
                } //ZStack
                
                Spacer()
                
                //MARK: - Footer
                
                ZStack{
                    
                    //1.Background
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    //2.Text
                    
                    Text("Start")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                    
                    //3. Capsule Dynamic
                    
                    HStack{
                        
                        Capsule()
                            .fill(.colorRed)
                            .frame(width: 80 + buttonOffset)
                        
                        Spacer()
                    } //HStack
                 
                    //4.Dragable Cricle
                    
                    HStack {
                        
                        ZStack{
                            
                            Circle()
                                .fill(.colorRed)
                            Circle()
                                .fill(.black.opacity(0.2))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                            
                        }  // ZStack(End of Dragable Cricle)
                        .offset(x: buttonOffset)
                        
                        .gesture(DragGesture()
                        
                            .onChanged({ gesture in
                                
                                if gesture.translation.width > 0.0 && buttonOffset <= buttonWidth - 80  {
                                    buttonOffset = gesture.translation.width
                                }
                                
                            })
                        
                                .onEnded({ _ in
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        if buttonOffset >= buttonWidth/2 {
                                            isOnboarding = false
                                            playSound(soundFile: "chimeup", soundType: "mp3")
                                            feedback.notificationOccurred(.success)
                                        } else{
                                            buttonOffset = .zero
                                            feedback.notificationOccurred(.error)
                                        }
                                    }
                                })
                                 
                        ) // gesture
                        
                        Spacer()
                    } // HStack
                    
                    
                } // ZStack(End of Footer)
                .frame(height: 80, alignment: .center)
                .padding(.horizontal, 40)
                .offset(y: isSliding ? 0 : 40)
                .animation(.easeInOut(duration: 1), value: isSliding)
                
                
            } // VStack
            
            
            
        } // ZStack
        .onAppear {
            isScaling.toggle()
            isSliding.toggle()
        }
        
        
    }
}

#Preview {
    Onboarding()
}
