//
//  FNUIKitAssembly.swift
//  FNUIKit
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation
import Swinject

public class FNUIKitAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(LoadingIndicatorProvider.self) { _ in
            return LoadingIndicator()
        }
    }

}
