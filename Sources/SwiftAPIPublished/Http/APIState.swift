//
//  APIState.swift
//
//
//  Created by Wttch on 2024/1/1.
//

import Foundation
import Combine
import SwiftUI

@propertyWrapper
struct APIState<T: Codable>: DynamicProperty {
    private let index: String
    
    @ObservedObject private var result: RequestResult
    
    var wrappedValue: T {
        get {
            return result.data
        }
        nonmutating set {
            self.result.data = newValue
        }
    }
    
    var projectedValue: RequestResult {
        return result
    }
    
    
    class RequestResult: ObservableObject {
        @Published var running: Bool = false
        @Published var data: T
        let completionPublisher = PassthroughSubject<String, Never>()
        let errorPublisher = PassthroughSubject<Error, Never>()
        
        let index: String
        var anyCancellable: AnyCancellable? = nil
        
        init(_ data: T, index: String) {
            self._data = Published(initialValue: data)
            self.index = index
        }
        
        
        func post(_ data: (any Encodable)? = nil, jwt: String? = nil, delay: Float?=nil) {
            self.running = true
            self.anyCancellable = nil
        }        
    }
}

extension APIState {
    init(wrappedValue : T, _ index: String) {
        self.index = index
        self._result = ObservedObject(wrappedValue: RequestResult(wrappedValue, index: index))
    }
}
