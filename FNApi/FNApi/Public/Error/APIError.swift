//
//  APIError.swift
//  FNApi
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case userCanceled
    case jsonParsing
    case otherError(error: Error)
}

extension Error {
    func tryAsAPIError() -> APIError {
        return APIError.otherError(error: self)
    }
}

