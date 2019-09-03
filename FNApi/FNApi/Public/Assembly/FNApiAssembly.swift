//
//  FNApiAssembly.swift
//  FNApi
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Swinject

public class FNApiAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(VehicleService.self) { _ in
            return VehicleService()
        }
    }

}
