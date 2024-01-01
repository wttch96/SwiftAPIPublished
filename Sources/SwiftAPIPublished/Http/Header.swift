//
//  File.swift
//  
//
//  Created by Wttch on 2024/1/1.
//

import Foundation

enum HeaderKey: String {
    case ContentType = "Content-Type"
    case Accept = "Accept"
}

enum ContentType: String {
    case APPLICATION_JSON_UTF8 = "application/json; charset=utf-8"
}
