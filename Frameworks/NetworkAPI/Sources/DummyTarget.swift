//
//  TestRequest.swift
//  NetworkAPI
//
//  Created by ibnu on 26/04/24.
//

import Foundation
import Moya

public enum DummyService {
    case products
}

extension DummyService: Moya.TargetType {
    public var baseURL: URL { URL(string: "https://dummyjson.com")! }
    public var path: String { "/products"}
    public var method: Moya.Method { .get }
    public var headers: [String: String]? { ["Content-type": "application/json"] }
    public var task: Task { .requestPlain }
}
