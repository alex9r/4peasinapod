//
//  seedPouchPopUp.swift
//  mastermind
//
//  Created by Alexandra Roszczenko on 2025-03-02.
//

import SwiftUI

struct SeedPouchPopupView: View {
    // Binding to the state from the parent view
    @Binding var isPresented: Bool
    @State private var selectedColors: [guessColour] = []
    
    var body: some View {
        ZStack {
            
            
            // Close button at the top-right corner
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(r: 52/255, g: 24/255, b: 16/255))
                    }
                }
                
                Text("Select Your Dye Colors")
                    .font(.headline)
                    .foregroundColor(.white)
                
                // **Dye Selection Grid**
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 15) {
                        ForEach(guessColours, id: \.name) { gColour in
                            Button(action: {
                                if selectedColors.count < 4 { // Max 4 colors
                                    selectedColors.append(gColour)
                                }
                            }) {
                                Image(gColour.name) // Uses the PNG name
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 85)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .padding()
                }
                
                // Display Selected Colors (Guess Area)
                HStack {
                    ForEach(selectedColors.indices, id: \.self) { index in
                        Button(action: {
                            selectedColors.remove(at: index) // Remove tapped dye
                        }) {
                            Image(selectedColors[index].name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .shadow(radius: 5)
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                
                // Submit Button
                Button(action:
                        {
                            if selectedColors.count == 4 {
                                submitGuess() // Submit the guess when 4 colors are selected
                            }})
                {
                    Image("Submit")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 80)
                        .shadow(radius: 5)
                }
                .disabled(selectedColors.count != 4) // Disable button if not 4 colors
                .opacity(selectedColors.count == 4 ? 1.0 : 0.5) // Dim the button if not ready

            }
            .padding()
        }
    }
    func submitGuess() {
        print("Submitted Guess: \(selectedColors)")
        selectedColors.removeAll()
    }
}

#Preview {
    SeedPouchPopupView(isPresented: .constant(true))
}


