//
//  Application.swift
//  FreeNow
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

import Foundation
import Swinject
import SwinjectStoryboard
import FNUIKit
import FNApi

private protocol FNUIApplicationRoot {
    var strongDelegate: UIApplicationDelegate? { get set }
    func createAssembler() -> Assembler
    func createAssembler(container: Container) -> Assembler
}

extension FNUIApplicationRoot {
    func createAssembler() -> Assembler {
        return createAssembler(container: SwinjectStoryboard.defaultContainer)
    }

    func createAssembler(container: Container) -> Assembler {
        let assemblies: [Assembly] = [
            FNApiAssembly(),
            FNUIKitAssembly(),
            FNMainAssembly()
        ]
        return Assembler(assemblies, container: container)
    }
}

/**
 Provides an entry point for our application. We use this class as the composition root for the purposes of dependency injection.

 - note: We need to hold onto a copy of the application delegate we create due to the aggressive nature of ARC and our superclass delegate property being weak.
 */
class Application: UIApplication, FNUIApplicationRoot {

    fileprivate var strongDelegate: UIApplicationDelegate?
    private var assembler: Assembler!

    override init() {
        super.init()

        assembler = createAssembler()

        Container.loggingFunction = nil

        let resolver = assembler.resolver
        let appDelegate = resolver.forceResolve(AppDelegate.self)

        strongDelegate = appDelegate
        delegate = strongDelegate
    }
}
