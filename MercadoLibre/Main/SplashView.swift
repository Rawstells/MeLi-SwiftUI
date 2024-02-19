//
//  SplashView.swift
//  MercadoLibre
//
//  Created by Joan Narvaez on 19/02/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ProductsFactory.getProductsView()
        } else {
            ZStack {
                Color(Color.primaryYellow)
                Image("MeLiLogo")
                    .font(.system(size: 10))
                    .foregroundColor(.red)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
            }
            .background(Color.primaryYellow)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
