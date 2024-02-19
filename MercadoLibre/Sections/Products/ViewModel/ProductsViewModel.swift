//
//  ProductsViewModel.swift
//  MercadoLibre
//
//  Created by Joan Narvaez on 15/02/24.
//

import Foundation
import Combine

@Observable class ProductsViewModel {
    var repository: ProductsRepositoryProtocol
    var products:  [ProductResultResponse] = []
    var showError = false
    var errorMessage: String = ""
    var isLoading = false
    
    var searchText = String()
    
    var subscriptions: Set<AnyCancellable> = []

    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
    }

    @MainActor
    func getProducts(product: String) async {
        isLoading = true
        do {
            let productResponse: [ProductResultResponse] = try await repository.getProducts(product: product)
            products = productResponse
        } catch {
            showError = true
            errorMessage = "Ha ocurrido un error, reintenta más tarde"
        }
        isLoading = false
    }
    
    func search() async {
        let debouncer = Debouncer(duration: .seconds(0.5))
        guard await debouncer.sleep() else { return }
        if searchText.count < 1 {
            self.products = []
            return
        }
        Task { await getProducts(product: searchText) }
    }
}
