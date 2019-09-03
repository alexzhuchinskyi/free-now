//
//  DigitConverter.swift
//  FNFoundation
//
//  Created by Alexandr Zhuchinskiy on 9/2/19.
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

public extension String {
    var doubleValue: Double {
        return Double(self) ?? 0.0
    }
}

extension String {
    var intValue: Int {
        return Int(self) ?? 0
    }
}
