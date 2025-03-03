//
//  gameState.swift
//  mastermind
//
//  Created by Alexandra Roszczenko on 2025-02-27.
//

import SwiftUI

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
