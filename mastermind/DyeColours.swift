//
//  DyeColours.swift
//  mastermind
//
//  Created by Alexandra Roszczenko on 2025-03-04.
//

import SwiftUI

struct guessColour {
    let name: String // This serves as both the image name and color name
}

// Define your dye colors using just one field
let guessColours: [guessColour] = [
    guessColour(name: "Red"),
    guessColour(name: "Blue"),
    guessColour(name: "Green"),
    guessColour(name: "Yellow"),
    guessColour(name: "DyePurple"),
    guessColour(name: "DyeOrange"),
    guessColour(name: "DyePink"),
    guessColour(name: "DyeTeal")
]
