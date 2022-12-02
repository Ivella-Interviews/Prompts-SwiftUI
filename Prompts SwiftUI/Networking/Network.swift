//
//  Network.swift
//  iOSInterview
//
//  Created by Eric Jubber on 11/30/22.
//

import Foundation

class Network {
    static let shared: Network = Network()
    
    private let config: URLSessionConfiguration
    private let session: URLSession
    
    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func request<T: Decodable>(router: Router, completion: @escaping (Result<T, Error>) -> ()) {
        do {
            // TO-DO: Implement network call with response parsing
            
        } catch let error {
            completion(.failure(error))
        }
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
