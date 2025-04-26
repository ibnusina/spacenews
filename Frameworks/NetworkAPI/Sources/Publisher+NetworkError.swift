//
//  Publisher+NetworkError.swift
//  NetworkAPI
//
//  Created by ibnu on 26/04/24.
//

import Combine
import Moya
import Foundation

extension Publisher where Output == Response, Failure == NetworkError {
    public func decode<Item>(type: Item.Type, keypath: String) -> Publishers.FlatMap<AnyPublisher<Item, Failure>, Self> where Item : Decodable {
        return flatMap { response in
            let publisher: AnyPublisher<Item, Failure>
            do {
                let value = try response.map(type, atKeyPath: keypath, using: JSONDecoder())
                publisher = CurrentValueSubject<Item, Failure>(value).eraseToAnyPublisher()
            } catch {
                publisher = Fail<Item, Failure>(error: .objectMapping(error, response)).eraseToAnyPublisher()
            }
            return publisher.prefix(1).eraseToAnyPublisher()
        }
    }
}
