
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isFlipped = false
    @State private var isPressed = false
    @State private var navigateToGame = false
    
    var body: some View {
        if navigateToGame {
            GameView()  // Show GameView when the state is true
        } else {
            VStack {
                ZStack {
                    Image("Title")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 190)
                    
                    Image("in a i")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .offset(x: -80, y: 90)
                    Image("in a n")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .offset(x: -25, y: 90)
                    Image("in a a")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .offset(x:80, y: 90)
                        
                    ZStack {
                        Image("Tiny Pea")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 50)
                            .offset(x: 30, y: 90)
                            .opacity(isFlipped ? 0 : 1)
                        
                        Image("Tiny Pea Smile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 50)
                            .offset(x: 30, y: 90)
                            .opacity(isFlipped ? 1 : 0)
                            .onReceive(Timer.publish(every: 5, on: .main, in: .common).autoconnect()) { _ in
                                isFlipped.toggle()
                            }
                    }
                }
                Spacer()
                
                // The Button to trigger the state change
                Image("Play")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 190, height: 80)
                    .padding(.top, 0)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                            isPressed = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            isPressed = false
                            navigateToGame = true  // Switch to GameView
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
