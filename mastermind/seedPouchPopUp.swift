//
//  seedPouchPopUp.swift
//  mastermind
//
//  Created by Alexandra Roszczenko on 2025-03-02.
//

import SwiftUI

struct SeedPouchPopupView: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            Text("You opened the Seed Pouch!")
                .font(.title)
                .padding()

            Button(action: {
                // Close the pop-up by setting isPresented to false
                isPresented = false
            }) {
                Text("Close")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

