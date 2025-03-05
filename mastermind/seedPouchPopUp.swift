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
            //            RadialGradient(
            //                gradient: Gradient(colors: [Color.brown.opacity(0.5), Color.brown.opacity(0.7)]),
            //                center: .center,
            //                startRadius: 10,
            //                endRadius: 300
            //            )
            //            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("seed pouch")
                    .font(.title)
                    .padding()
                    .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            
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
                            .padding()
                    }
                }
                
                Text("Select Your Dye Colors")
                    .font(.headline)
                    .foregroundColor(.white)
                
                // **Dye Selection Grid**
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 15) {
                        ForEach(guessColours, id: \.name) { gColour in
                            Button(action: {
                                if selectedColors.count < 4 { // Max 4 colors
                                    selectedColors.append(gColour)
                                }
                            }) {
                                Image(gColour.name) // Uses the PNG name
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
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
                Button(action: {
                    submitGuess()
                }) {
                    Text("Submit Guess")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedColors.count == 4 ? Color.green : Color.gray)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(selectedColors.count != 4) // Disable if not 4 colors
                
                Spacer()
            }
            .padding()
        }
    }
    func submitGuess() {
        print("Submitted Guess: \(selectedColors)")
        selectedColors.removeAll()
    }
}


