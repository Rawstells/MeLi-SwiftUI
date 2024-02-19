//
//  Debouncer.swift
//  MercadoLibre
//
//  Created by Joan Narvaez on 20/02/24.
//

import Foundation

public actor Debouncer {
    private let duration: Duration
    private var isPending = false
    
    public init(duration: Duration) {
        self.duration = duration
    }
    
    public func sleep() async -> Bool {
        if isPending { return false }
        isPending = true
        try? await Task.sleep(for: duration)
        isPending = false
        return true
    }
}
