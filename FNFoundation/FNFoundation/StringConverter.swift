//
//  StringConverter.swift
//  FNFoundation
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

public protocol StringConvertable {
    var stringValue: String { get }
}

extension Double: StringConvertable {
    public var stringValue: String {
        return String(self)
    }
}

extension Int: StringConvertable {
    public var stringValue: String {
        return String(self)
    }
}
