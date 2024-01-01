//
//  NetworkError.swift
//  
//
//  Created by Wttch on 2023/12/26.
//

import Foundation

///
/// 网络请求错误。
///
enum NetworkError: LocalizedError {
    /// 网络错误
    case networkError(msg: String)
    /// http 请求 code 不为 200
    case badResponse(code: Int)
}

extension NetworkError {
//    /// 将网络错误转换为 ServiceError
//    /// - Returns: 服务错误
//    func toServiceError() -> ServiceError {
//        switch self {
//        case .badResponse(let code):
//            return ServiceError.badRequest(code: code, msg: nil)
//        case .networkError(let msg):
//            return ServiceError.badRequest(code: nil, msg: msg)
//        }
//    }
}
