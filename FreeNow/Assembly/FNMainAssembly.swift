//
//  FNMainAssembly.swift
//  FreeNow
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import FNApi
import FNFoundation
import FNUIKit

class FNMainAssembly: Assembly {

    func assemble(container: Container) {

        container.register(AppDelegate.self) { _ in
            return AppDelegate()
        }.inObjectScope(.container)

        container.register(VehiclesViewStateFactory.self) { _ in
            return VehiclesViewStateFactory()
        }

        container.register(VehicleSearchKitchen.self) { resolver in
            let vehicleService = resolver.forceResolve(VehicleService.self)
            let viewStateFactory = resolver.forceResolve(VehiclesViewStateFactory.self)
            return VehicleSearchKitchen(vehicleService: vehicleService, viewStateFactory: viewStateFactory)
        }

        container.storyboardInitCompleted(VehicleListViewController.self) { resolver, controller in
            let kitchen = AnyKitchen(resolver.forceResolve(VehicleSearchKitchen.self))
            controller.inject(kitchen: kitchen, loadingIndicator: resolver.forceResolve(LoadingIndicatorProvider.self))

            kitchen.delegate = AnyKitchenDelegate(controller)
        }

        container.register(VehicleMapKitchen.self) { resolver in
            let vehicleService = resolver.forceResolve(VehicleService.self)
            let viewStateFactory = resolver.forceResolve(VehiclesViewStateFactory.self)
            return VehicleMapKitchen(vehicleService: vehicleService, viewStateFactory: viewStateFactory)
        }

        container.storyboardInitCompleted(VehicleMapViewController.self) { resolver, controller in
            let kitchen = AnyKitchen(resolver.forceResolve(VehicleMapKitchen.self))
            controller.inject(kitchen: kitchen, loadingIndicator: resolver.forceResolve(LoadingIndicatorProvider.self))

            kitchen.delegate = AnyKitchenDelegate(controller)
        }
    }
}
