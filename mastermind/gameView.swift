//
//  gameView.swift
//  mastermind
//
//  Created by Alexandra Roszczenko on 2025-02-27.
//

import SwiftUI
/*
struct GameView: View {
    @StateObject private var gameState = GameState()  // Observe game state
    @State private var currentRound: Int = 0  // Track the current round
    @StateObject private var appState = AppState()
    @State private var pouchIsPressed = false
    @State private var openPouch = false
    @State private var diaryIsPressed = false
    @State private var openDiary = false
    @State private var menuIsPressed = false
    @State private var openMenu = false
    @State private var guesses: [[guessColour]] = []
    @State private var currentGuess: [guessColour] = []
    
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<guesses.count, id: \.self) { index in
                            GuessView(guess: guesses[index])
                        }
                    }
                }
                BottomButtonsView(
                    pouchIsPressed: $pouchIsPressed,
                    openPouch: $openPouch,
                    diaryIsPressed: $diaryIsPressed,
                    openDiary: $openDiary,
                    menuIsPressed: $menuIsPressed,
                    openMenu: $openMenu
                )
                .sheet(isPresented: $openPouch) {
                    SeedPouchPopupView(isPresented: $openPouch, currentGuess: $currentGuess, guesses: $guesses)
                }
            }
        }
    }
}*/

struct GameView: View {
    @StateObject private var gameState = GameState()  // Observe game state
    @State private var currentRound: Int = 0  // Track the current round
    @State private var guesses: [[GameState.Colour]] = [] // Array to store guesses for UI
    @State private var currentGuess: [guessColour] = [] // The current guess that the user makes
    
    var body: some View {
        ZStack {
            VStack {
                // Display guesses and feedback (bees and ladybugs)
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(0..<gameState.guesses.count, id: \.self) { index in
                            VStack {
                                // Display the Guess images (colours)
                                HStack {
                                    ForEach(gameState.guesses[index].colours, id: \.self) { color in
                                        Circle()
                                            .fill(Color(named: color.rawValue) ?? .clear) // Assuming you have a Color initializer for these values
                                            .frame(width: 30, height: 30)
                                    }
                                }

                                // Display feedback (bees and ladybugs)
                                HStack {
                                    // Display Ladybugs
                                    ForEach(0..<gameState.guesses[index].ladybugs, id: \.self) { _ in
                                        Image("Ladybug") // Image asset for Ladybug
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                    }
                                    
                                    // Display Bees
                                    ForEach(0..<gameState.guesses[index].bees, id: \.self) { _ in
                                        Image("Bee") // Image asset for Bee
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                    }
                                }
                            }
                        }
                    }
                }

                // Button for submitting the guess
                Button(action: submitGuess) {
                    Text("Submit Guess")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
        }
    }

    func submitGuess() {
        // Ensure the current guess has 4 colors
        guard currentGuess.count == 4 else { return }
        
        // Convert current guess to [Color] for evaluation
        let guessColors = currentGuess.map { $0.colour }

        // Call the submitGuess method in GameState to evaluate the guess
        let (bees, ladybugs) = gameState.evaluateGuess(guessColors)

        // Create the Guess object and assign the feedback (bees, ladybugs)
        let guess = GameState.Guess(colours: guessColors)
        guess.bees = bees
        guess.ladybugs = ladybugs

        // Store the guess and its feedback
        gameState.guesses.append(guess)

        // Add the guess to the UI display
        guesses.append(currentGuess.map { $0.colour }) // You can use this to populate the UI with colors
        
        // Reset current guess
        currentGuess.removeAll()

        // Optionally, you can check for win condition
        if ladybugs == 4 {
            // Display a win message
            print("You win!")
        }
    }
}


struct GuessView: View {
    var guess: [guessColour]
    
    var body: some View {
        ZStack {
            Image("Guess")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .shadow(radius: 5)
                .cornerRadius(15)

            // Overlay the colors from the guess
            ForEach(0..<guess.count, id: \.self) { colorIndex in
                Image(guess[colorIndex].name) // Use the image name directly
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .offset(x: CGFloat(20 * colorIndex), y: 0)
            }
        }
        .padding(.vertical, 5)
    }
}

// MARK: - Bottom Buttons View
struct BottomButtonsView: View {
    @Binding var pouchIsPressed: Bool
    @Binding var openPouch: Bool
    @Binding var diaryIsPressed: Bool
    @Binding var openDiary: Bool
    @Binding var menuIsPressed: Bool
    @Binding var openMenu: Bool
    
    var body: some View {
        HStack(spacing: -50) {
            ButtonView(imageName: "Diary", isPressed: $diaryIsPressed, action: {
                diaryIsPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    diaryIsPressed = false
                    openDiary = true
                }
            })
            ButtonView(imageName: "Seed Pouch", isPressed: $pouchIsPressed, action: {
                pouchIsPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    pouchIsPressed = false
                    openPouch.toggle()
                }
            })
            ButtonView(imageName: "Menu", isPressed: $menuIsPressed, action: {
                menuIsPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    menuIsPressed = false
                    openMenu = true
                }
            })
        }
        .padding(.vertical, 15)
        .background(Color.green.opacity(0.2))
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Button View
struct ButtonView: View {
    var imageName: String
    @Binding var isPressed: Bool
    var action: () -> Void
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .offset(y: -10)
            .frame(width: 190, height: 80)
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .onTapGesture {
                withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isPressed = false
                    action()
                }
            }
    }
}

// MARK: - Flipping Image View
struct FlippingImageView: View {
    @Binding var isFlipped: Bool

    var body: some View {
        ZStack {
            Image("Tiny Pea")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 50)
                .opacity(isFlipped ? 0 : 1)

            Image("Tiny Pea Smile")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 50)
                .opacity(isFlipped ? 1 : 0)
                .onReceive(Timer.publish(every: 5, on: .main, in: .common).autoconnect()) { _ in
                    isFlipped.toggle()
                }
        }
    }
}

#Preview {
    GameView()
}
