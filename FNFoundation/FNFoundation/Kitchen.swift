//
//  Kitchen.swift
//  FNFoundation
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Foundation

public protocol Kitchen {
    associatedtype ViewEvent
    associatedtype Command

    func receive(event: ViewEvent)
    var delegate: AnyKitchenDelegate<Command>? { get set }
}

public class AnyKitchen<E, C>: Kitchen {
    private let box: AbstractKitchen<E, C>

    public init<K: Kitchen>(_ kitchen: K) where K.ViewEvent == E, K.Command == C {
        box = AnyKitchenBox(kitchen)
    }

    public func receive(event: E) {
        box.receive(event: event)
    }

    public var delegate: AnyKitchenDelegate<C>? {
        get {
            return box.delegate
        }
        set {
            box.delegate = newValue
        }
    }
}

// MARK: - Implementation

private class AbstractKitchen<E, C>: Kitchen {
    func receive(event: E) { fatalError("abstract needs override") }
    var delegate: AnyKitchenDelegate<C>? {
        get { fatalError("abstract needs override") }
        set { fatalError("abstract needs override") }
    }
}

private class AnyKitchenBox<K: Kitchen>: AbstractKitchen<K.ViewEvent, K.Command> {
    private var _delegate: AnyKitchenDelegate<K.Command>?
    private var concrete: K

    init(_ concrete: K) {
        self.concrete = concrete
    }

    override func receive(event: K.ViewEvent) {
        concrete.receive(event: event)
    }

    override var delegate: AnyKitchenDelegate<K.Command>? {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
            concrete.delegate = newValue
        }
    }
}
