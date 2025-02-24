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
    
class AppState: ObservableObject {
    @Published var backgroundColor: Color = Color(red:62, green:97, blue:57)
    @Published var showPopup: Bool = false
    @Published var popupMessage: String = ""
    
}

struct GameView: View {
    @StateObject private var gameState = GameState()  // Observe game state
    // @State private var currentGuess: Guess
    @State private var currentRound: Int = 0  // Track the current round
    @StateObject private var appState = AppState()
    @State private var sacIsPressed = false
    
    var body: some View {
        ZStack {
            Color.clear
                .background(appState.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Scrollable Field at the Top
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(1..<21) { index in
                            Text("Item \(index)")
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                
                // Buttons at the Bottom
                HStack(spacing: 20) {
                    Image("Diary")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190, height: 80)
                        .padding(.top, 0)
                        .scaleEffect(sacIsPressed ? 0.9 : 1.0)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                sacIsPressed = true
                            }
                    
                    Image("Seed Pouch")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 190, height: 80)
                            .padding(.top, 0)
                            .scaleEffect(sacIsPressed ? 0.9 : 1.0)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                    sacIsPressed = true
                                    Text("you pressed seed pouch")
                                }
                            }
                
            }
        }
        // Popup Visual
        .sheet(isPresented: $appState.showPopup) {
           // PopupView(message: appState.popupMessage)
        }
    }

    
}
    
class GameState: ObservableObject {
    @Published var secretCode: [gameColour]
    @Published var guesses: [Guess] = []
    
    init() {
        self.secretCode = []
        startNewGame()
    }
    
    struct gameColour {
        let colour: Colour
        var guessed: Bool = false
    }
    
    struct Guess {
        let colours: [Colour]   // 4 colour guess
        var bees = 0            // white, correct colour and incorrect spot
        var ladybugs = 0        // red, correct colour and spot
        // Enforce exactly 4 colors in the initializer
        init(colours: [Colour]) {
            guard colours.count == 4 else {
                fatalError("A guess must contain exactly 4 colours.")
            }
            self.colours = colours
            }
    }
    
    enum Colour: String, CaseIterable {
        case red = "Red"
        case blue = "Blue"
        case green = "Green"
        case yellow = "Yellow"
        case orange = "Orange"
        case purple = "Purple"
        case silver = "Silver"
        case black = "Black"
        case pink = "Pink"
        case white = "White"
    }
    
    func generateRandomAnswer() -> [gameColour] {
        let allColors = Colour.allCases
        var answer: [gameColour] = []
        
        for _ in 0..<4 {
            if let randomColour = allColors.randomElement() {
                answer.append(gameColour(colour: randomColour))
            }
        }
        
        return answer
    }
    
    
    func startNewGame() {
        self.secretCode = generateRandomAnswer()
        
    }
    
    func submitGuess(_ guessColors: [Color], forRound round: Int) {}
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

