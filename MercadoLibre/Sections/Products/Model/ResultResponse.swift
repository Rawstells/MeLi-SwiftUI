//
//  ResultResponse.swift
//  MercadoLibre
//
//  Created by Joan Narvaez on 15/02/24.
//

import Foundation
import SwiftData

class ProductResultResponse: Codable, Identifiable {
    var id: String
    var title: String
    var thumbnail: String
    var price: Double?
    var originalPrice: Double?
    var permalink: String
    
    var formattedPrice: String { .init(format: "%.0f", price ?? 0) }

    var imageUrl: URL? { .init(string: thumbnail.replacingOccurrences(of: "http:", with: "https:") ) }

    enum CodingKeys: String, CodingKey {
        case title, thumbnail, id, price, originalPrice = "original_price", permalink
    }

    init(id: String, title: String, thumbnail: String, price: Double? = nil, originalPrice: Double? = nil, permalink: String) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.price = price
        self.originalPrice = originalPrice
        self.permalink = permalink
    }

}

extension ProductResultResponse: Equatable {
    static func == (lhs: ProductResultResponse, rhs: ProductResultResponse) -> Bool {
        lhs.id == rhs.id
    }
}
