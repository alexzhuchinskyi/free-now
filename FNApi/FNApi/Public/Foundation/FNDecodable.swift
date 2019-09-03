//
//  FNDecodable.swift
//  FNApi
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

public protocol FNDecodable {
    static func decode(data: Data) throws -> Self
}

public func decode<T: FNDecodable>(_ data: Data) throws -> T {
    return try T.decode(data: data)
}
