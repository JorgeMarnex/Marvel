//
//  Observable.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Foundation

public final class Observable<Value> {
    
    private var closure: ((Value) -> ())?

    public var value: Value {
        didSet { closure?(value) }
    }

    public init(_ value: Value) {
        self.value = value
    }

    public func observe(_ closure: @escaping (Value) -> Void) {
        self.closure = closure
        closure(value)
    }
}
