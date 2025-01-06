//
//  Item.swift
//  Games.macOS
//
//  Created by Michael Ventimiglia on 6/25/24.
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
