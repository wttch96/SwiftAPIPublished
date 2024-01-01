//
//  ServiceError.swift
//  
//
//  Created by Wttch on 2024/1/1.
//

import Foundation


protocol ServiceError {
    init(_ error: NetworkError)
}
