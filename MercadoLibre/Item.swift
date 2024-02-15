//
//  Item.swift
//  MercadoLibre
//
//  Created by Joan Narvaez on 15/02/24.
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
