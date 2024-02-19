//
//  ProductsFactory.swift
//  MercadoLibre
//
//  Created by Joan Narvaez on 16/02/24.
//

enum ProductsFactory {
    static func getProductsView() -> ProductsView {
        let apiManager = APIManager()
        let repository = ProductsRepository(apiManager: apiManager)
        let viewModel = ProductsViewModel(repository: repository)
        return ProductsView(viewModel: viewModel)
    }
}
