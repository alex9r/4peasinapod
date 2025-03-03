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
                Spacer()
            }
            .padding()
            .background(Color(r: 95/255, g: 64/255, b: 55/255)) // Background color for the popup content
            .cornerRadius(20) // Optional: to round the corners of the popup
            .shadow(radius: 10) // Optional: add a shadow for better visibility
        }
    }
}


