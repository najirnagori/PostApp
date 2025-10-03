//
//  NetworkingManager.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingError(Error)
    case unknown
}

protocol NetworkServiceProtocol {
    func fetchPosts() -> AnyPublisher<[Post], NetworkError>
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    func fetchPosts() -> AnyPublisher<[Post], NetworkError> {
        guard let url = URL(string: "\(baseURL)/posts") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let decodingError = error as? DecodingError {
                    return .decodingError(decodingError)
                } else {
                    return .requestFailed(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
