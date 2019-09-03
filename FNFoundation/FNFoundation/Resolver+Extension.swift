//
//  Resolver+Extension.swift
//  FNFoundation
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation
import Swinject

extension Resolver {
    public func forceResolve<T>(_: T.Type, name: String? = nil) -> T {
        return forceCast(self.resolve(T.self, name: name), T.self, justification: .injectionRequirement)
    }
}
