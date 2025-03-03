//
//  appState.swift
//  mastermind
//
//  Created by Alexandra Roszczenko on 2025-02-27.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var backgroundColor: Color = Color(red: 62, green: 97, blue: 57)
    @Published var showPopup: Bool = false
    @Published var popupMessage: String = ""
}
