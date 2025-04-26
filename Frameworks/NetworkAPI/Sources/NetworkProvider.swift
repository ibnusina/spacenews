//
//  NetworkProvider.swift
//  Authentication
//
//  Created by Dimas Prabowo on 04/06/23.
//  Copyright © 2023 PT. Good Doctor Technology. All rights reserved.
//

import Alamofire
import Combine
import CombineMoya
import Moya

open class NetworkProvider<Target> where Target: Moya.TargetType {
    private let provider: MoyaProvider<Target>
    
    public init() {
        provider = MoyaProvider()
    }
    
    public func request(
        _ target: Target,
        retry times: Int = 2
    ) -> AnyPublisher<Response, NetworkError> {
        return provider.requestPublisher(target).mapError { moyaError in
            NetworkError(moyaError: moyaError)
        }.retry(times).eraseToAnyPublisher()
    }
}
