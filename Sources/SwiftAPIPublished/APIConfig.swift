//
//  APIConfig.swift
//
//
//  Created by Wttch on 2023/12/26.
//

import Foundation


/// API 配置
public class APIConfig {
    /// API 根路径
    let rootPath: String
    
    init(rootPath: String) {
        self.rootPath = rootPath
    }
    
    public static var shared: APIConfig = APIConfig(rootPath: "")
}

