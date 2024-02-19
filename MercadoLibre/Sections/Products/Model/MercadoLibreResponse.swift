//
//  MercadoLibreResponse.swift
//  MercadoLibre
//
//  Created by Joan Narvaez on 15/02/24.
//

import Foundation

final class ProductResponse: Codable {
    var results: [ProductResultResponse]

    init(results: [ProductResultResponse]) {
        self.results = results
    }
}

extension ProductResponse: Equatable {
    static func == (lhs: ProductResponse, rhs: ProductResponse) -> Bool {
        lhs.results == rhs.results
    }
}

