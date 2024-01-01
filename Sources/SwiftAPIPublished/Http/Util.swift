//
//  Util.swift
//
//
//  Created by Wttch on 2024/1/1.
//

import Foundation


extension HTTPURLResponse {
    
    var isSuccess: Bool {
        let statusCode = self.statusCode
        return statusCode >= 200 && statusCode < 300
    }
}
