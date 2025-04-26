//
//  NetworkError+Strings.swift
//  NetworkAPI
//
//  Created by Dimas Agung Prabowo on 13/02/24.
//  Copyright © 2024 GOOD DOCTOR TECHNOLOGY. All rights reserved.
//

import Foundation

extension String {
    public static var serverError: Self {
        return "Server error"
    }
    
    public static var pageNotFound: Self {
        return "Page not found"
    }
    
    public static var fullVisitor: Self {
        return "Server full visitor"
    }
    
    public static var timeout: Self {
        return "Timeout error"
    }
    
    public static var unauthorized: Self {
        return "Unauthorized error"
    }
    
    public static var forbidden: Self {
        return "Forbidden error"
    }
    
    public static var badRequest: Self {
        return "Bad request error"
    }
    
    public static var unprocessableEntity: Self {
        return "Unprocessable entity"
    }
    
    public static var undefinedRequestError: Self {
        return "Undefined request error"
    }
    
    public static func decodeError(
        structName: String,
        debugDescription: String
    ) -> Self {
        return "Decode Error: \(debugDescription) -> Object: \(structName)"
    }
}
