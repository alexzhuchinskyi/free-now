//
//  ForceCast.swift
//  FNFoundation
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

/**
 Possible reasons for performing a force cast.
 */
public enum ForceCastJustification: String {
    case loadingFromNib
    case segueDestination
    case loadingFromStoryboard
    case requiredUIState
    case objcInterop
    case transitionAnimation
    case routingURL
    case injectionRequirement
    case cantBeNilAtThisPoint
}

/**
 If you ever need to force cast something, you should have a good reason. Use this method to provide that reason.
 */
public func forceCast<T>(_ objectToCast: Any?, _: T.Type, justification: ForceCastJustification, file: String = #file, method: String = #function, line: Int = #line) -> T {
    guard let castedObject = objectToCast as? T else {
        return objectToCast as! T
    }
    return castedObject
}
