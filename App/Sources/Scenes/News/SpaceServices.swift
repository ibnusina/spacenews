//
//  SpaceServices.swift
//  App
//
//  Created by ibnu on 26/04/25.
//

import Foundation
import Moya

public enum SpaceService {
    case articles
    case blogs
    case reports
}

extension SpaceService: Moya.TargetType {
    public var baseURL: URL {
        
        URL(string: "https://api.spaceflightnewsapi.net/v4")!
    }
    public var path: String {
        switch self {
        case .articles:
            return "/articles/"
        case .blogs:
            return "/blogs/"
        case .reports:
            return "/reports/"
        }
    }
    public var method: Moya.Method { .get }
    public var headers: [String: String]? { ["Content-type": "application/json"] }
    public var task: Task { .requestPlain }
}
