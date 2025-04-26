//
//  NetworkError.swift
//  Authentication
//
//  Created by Dimas Prabowo on 04/06/23.
//  Copyright © 2023 PT. Good Doctor Technology. All rights reserved.
//

import Moya

public enum NetworkError: Error {
    case imageMapping(Response)
    case jsonMapping(Response)
    case stringMapping(Response)
    case objectMapping(Swift.Error, Response)
    case encodableMapping(Swift.Error)
    case statusCode(Response)
    case underlying(Swift.Error, Response?)
    case requestMapping(String)
    case parameterEncoding(Swift.Error)
    case noInternet
    case underMaintenance
    case serverError(_ errorMessage: String = .serverError)
    case pageNotFound(_ errorMessage: String = .pageNotFound)
    case unauthorized(_ errorMessage: String = .unauthorized)
    case forbidden(_ errorMessage: String = .forbidden)
    case badRequest(_ errorMessage: String = .badRequest)
    case unprocessableEntity(_ errorMessage: String = .unprocessableEntity)
    case undefinedRequestError(_ errorMessage: String = .undefinedRequestError)
}

extension NetworkError {
    public init(moyaError: MoyaError) {
        switch moyaError {
        case let .imageMapping(response):
            self = .imageMapping(response)
        case let .jsonMapping(response):
            self = .jsonMapping(response)
        case let .stringMapping(response):
            self = .stringMapping(response)
        case let .objectMapping(error, response):
            self = .objectMapping(error, response)
        case let .encodableMapping(error):
            self = .encodableMapping(error)
        case let .statusCode(response):
            self.init(response: response)
        case let .underlying(error, response):
            self = .underlying(error, response)
        case let .requestMapping(message):
            self = .requestMapping(message)
        case let .parameterEncoding(error):
            self = .parameterEncoding(error)
        }
    }
    
    public init(response: Response) {
        switch response.statusCode {
        case 400:
            self = .badRequest(.badRequest)
            return
            
        case 401:
            self = .unauthorized(.unauthorized)
            return
            
        case 403:
            self = .forbidden(.forbidden)
            return
            
        case 404:
            self = .pageNotFound(.pageNotFound)
            return
            
        case 422:
            self = NetworkError.unprocessableEntity(.unprocessableEntity)
            return
            
        case 500...599:
            self = .serverError(.serverError)
            return
            
        default:
            self = .undefinedRequestError(.undefinedRequestError)
            return
        }
    }
    
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
    
    public var errorDescription: String {
        switch self {
        case let .unauthorized(message):
            return message
        case let .unprocessableEntity(message):
            return message
        case let .undefinedRequestError(message):
            return message
        case let .serverError(message):
            return message
        case let  .pageNotFound(message):
            return message
        case let .forbidden(message):
            return message
        case let .badRequest(message):
            return message
        case .noInternet, 
                .underMaintenance,
                .imageMapping,
                .jsonMapping,
                .stringMapping,
                .objectMapping,
                .encodableMapping,
                .statusCode,
                .underlying,
                .requestMapping,
                .parameterEncoding:
            return String(describing: self)
        }
    }
}

internal struct RequestErrorInfo: Decodable {
    internal let errors: [RequestErrorItem]
}

internal struct RequestErrorItem: Decodable {
    internal let message: String
    internal let code: Int
    internal let field: String?
}
