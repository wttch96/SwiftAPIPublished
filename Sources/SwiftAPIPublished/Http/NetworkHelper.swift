//
//  NetworkHelper.swift
//
//
//  Created by Wttch on 2023/12/26.
//

import Foundation
import Combine


extension DispatchQueue {
    public static var http: DispatchQueue {
        return Self.global(qos: .background)
    }
}

/// api 网路请求
/// 只是简单的 http 请求包装，不做太多的错误处理。
class NetworkHelper {
    
    static func request<T: Codable>(
        url urlStr: String,
        data: (any Encodable)?,
        type: T.Type,
        httpMethod: String? = "POST",
        headers: [HeaderKey: String]? = nil
    ) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlStr) else {
            // 拼接 url 出现问题，延迟后发送错误消息
            return urlErrorPublisher(type, url: urlStr)
        }
        
        var urlRequest = URLRequest(url: url)

        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key.rawValue)
            }
        }
        urlRequest.httpMethod = httpMethod
        
        // json 请求体
        if let data = data {
            urlRequest.httpBody = try? JSONEncoder().encode(data)
        }
        
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            // http 请求所在的线程
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap({ output in
                guard let resp = output.response as? HTTPURLResponse else {
                    throw NetworkError.networkError(msg: "\(url): url response 为空!")
                }
                
                guard resp.isSuccess else {
                    throw NetworkError.badResponse(code: resp.statusCode)
                }
                
                return output.data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private static func urlErrorPublisher<T>(_ type: T.Type, url: String) -> AnyPublisher<T, Error> {
        let requestPublisher = PassthroughSubject<T, Error>()
        
        requestPublisher.send(completion: .failure(NetworkError.networkError(msg: "请求url错误:\(url)")))
        
        return requestPublisher
            .delay(for: .seconds(0.2), scheduler: DispatchQueue.http)
            .subscribe(on: DispatchQueue.http)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
