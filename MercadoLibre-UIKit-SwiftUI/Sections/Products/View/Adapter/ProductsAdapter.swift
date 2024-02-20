//
//  ProductsAdapter.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import Combine
import SwiftUI
import UIKit

class SearchProductAdapter: NSObject {
    
    // MARK: - Internal Properties
    
    var products: [ProductResultResponse] = []
    
    // MARK: - Internal Observable Properties
    
    let didSelectItemAt = PassthroughSubject<(ProductResultResponse, [ProductResultResponse]), Never>()
}

// MARK: - UITableViewDataSource
extension SearchProductAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count == .zero ? tableView.setEmptyMessage(message: "Realiza una busqueda para listar productos") : tableView.removeEmptyMessage()
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ProductRow",
            for: indexPath
        )
        let product = products[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration {
            ProductsRowView(product: product)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchProductAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItemAt.send((products[indexPath.row], products))
    }
}
