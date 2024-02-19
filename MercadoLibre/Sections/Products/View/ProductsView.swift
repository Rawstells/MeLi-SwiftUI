//
//  ProductsView.swift
//  MercadoLibre
//
//  Created by Joan Narvaez on 15/02/24.
//

import SwiftUI
import SwiftData

struct ProductsView: View {
    
    @State private var viewModel: ProductsViewModel
    
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
    }
    
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack {
            VStack {
                headerView
                listView
            }
            .background(Color.lightGrayColor)
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {
                    viewModel.showError = false
                }
            }
        }
        .task {
            await viewModel.getProducts(product: "all")
        }.onChange(of: viewModel.searchText) { Task  { await viewModel.search() } }
    }
    
    private var headerView: some View {
        HStack(alignment: .center) {
            Image(systemName: "list.bullet")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .padding(.leading)
            searchField
            Image(systemName: "cart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding(.trailing)
            
        }
        .background(Color.primaryYellow)
    }
    
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(text: $viewModel.searchText, label: {
                Text("Buscar en Mercado Libre")
            })
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .clipped()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 0.5)
        )
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private var listView: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: adaptiveColumn,
                          spacing: 10) {
                    ForEach(viewModel.products,
                            id: \.id) { product in
                        NavigationLink {
                            ProductDetailView(product: product, relatedProducts: viewModel.products)
                        } label: {
                            ProductsRowView(product: product)
                                .frame(height: 250)
                        }
                    }
                }
            }.padding()
            if viewModel.isLoading { ProgressView() }
        }
    }
}

#Preview {
    ProductsFactory.getProductsView()
}
