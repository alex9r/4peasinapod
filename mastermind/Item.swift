//
//  Item.swift
//  mastermind
//
//  Created by Alexandra Roszczenko on 2025-02-11.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
