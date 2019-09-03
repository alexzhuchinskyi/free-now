//
//  main.swift
//  FreeNow
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

import UIKit

private func applicationClassName() -> String? {
    return NSStringFromClass(Application.self)
}

_ = UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), applicationClassName(), nil)
