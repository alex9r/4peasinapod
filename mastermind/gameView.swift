//
//  gameView.swift
//  mastermind
//
//  Created by Alexandra Roszczenko on 2025-02-27.
//

import SwiftUI
 
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
     
     var body: some View {
         ZStack {
             Color.clear
                 .background(appState.backgroundColor)
                 .edgesIgnoringSafeArea(.all)
             
             VStack {
                 // Scrollable Field at the Top
                 ScrollView {
                     LazyVStack(spacing: 0) {
                         ForEach(0..<14, id: \.self) { index in
                             ZStack {
                                 Image("Guess")
                                     .resizable()
                                     .scaledToFit()
                                     .cornerRadius(10)
                                     .shadow(radius: 5)
                                     .cornerRadius(15)
                                 // Overlay based on the player's guess
 //                                if let result = guessResults[index] {
 //                                    overlayForResult(result)
 //                                }
                             }
                         }
                     }
                 }
                 // Buttons at the Bottom
                 HStack(spacing:-50) {
                     Image("Diary")
                         .resizable()
                         .scaledToFit()
                         .offset(y: -10)
                         .frame(width: 190, height: 80)
                         .scaleEffect(diaryIsPressed ? 0.9 : 1.0)
                         .onTapGesture {
                             withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                 diaryIsPressed = true
                             }
                             DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                 diaryIsPressed = false
                                 openDiary = true
                             }
                         }
                     Image("Seed Pouch")
                         .resizable()
                         .scaledToFit()
                         .frame(width: 190, height: 80)
                         .scaleEffect(pouchIsPressed ? 0.9 : 1.0)
                         .onTapGesture {
                             withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                 pouchIsPressed = true
                             }
                             DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                 pouchIsPressed = false
                                 openPouch = true
                             }
                         }
                     Image("Menu")
                         .resizable()
                         .scaledToFit()
                         .offset(y: -10)
                         .frame(width: 190, height: 80)
                         .scaleEffect(menuIsPressed ? 0.9 : 1.0)
                         .onTapGesture {
                             withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                 menuIsPressed = true
                             }
                             DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                 menuIsPressed = false
                                 openMenu = true
                             }
                         }
                 }
                 .padding(.vertical, 15)
                 .background(Color.green.opacity(0.2)) // Light blue background with transparency
                 .cornerRadius(15) // Rounds the edges of the background
                 .shadow(radius: 5) // Adds a soft shadow
                 .frame(maxWidth: .infinity)
             }
         }
     }
 }
 
 #Preview {
     GameView()
 }
