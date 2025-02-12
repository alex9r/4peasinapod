//
//  ContentView.swift
//  mastermind
//
//  Created by Alexandra Roszczenko on 2025-02-11.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isFlipped = false
    @State private var isPressed = false
    // @Query private var items: [Item]
    
    var body: some View {
        VStack {
            ZStack {
                Image("Title")
                    .resizable()
                    .scaledToFit()
            
                Image("in a i")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .offset(x: -120, y: -4)
                Image("in a n")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .offset(x: -38, y: -4)
                Image("in a a")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .offset(x:120, y:-4)
                ZStack {
                    // Image A
                    Image("Tiny Pea")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 78, height: 65)
                        .offset(x: 40, y: -6)
                        .opacity(isFlipped ? 0 : 1)  // Hidden when flipped
                    
                    // Image B
                    Image("Tiny Pea Smile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 78, height: 65)
                        .offset(x: 40, y: -6)
                        .opacity(isFlipped ? 1 : 0)  // Visible when flipped
                }
                
                .onReceive(Timer.publish(every: 5, on: .main, in: .common).autoconnect()) { _ in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isFlipped.toggle()  // Toggle the flip
                    }
                            }

            }
            Spacer()
            NavigationLink(destination: GameView()) {
                Image("Play")  // Use your own image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 190, height: 80)
                    .padding(.top, 0)
                    .scaleEffect(isPressed ? 0.9 : 1.0)  // Click animation
                    .onTapGesture {
                        withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                            isPressed = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            isPressed = false
                        }
                    }
            }
            .buttonStyle(PlainButtonStyle())  // Removes default button style
        }
        .frame(height: 600)
    }
}
struct GameView: View {
    @State var turn: Int = 0
    var body: some View {
        VStack {
            Text("Turn: \(turn)")
            Button("Next Turn") {
                self.turn += 1
            }
        }
    }
}
    /* private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}
*/
#Preview {
    ContentView()
        
}

