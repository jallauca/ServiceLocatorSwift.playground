/*:
 # Service Locator Container

 */
//
//  Container.swift
//
//  Created by Jaime Allauca on 11/29/16.
//

import Foundation

public class Container {
    private var registry: [String:() -> Any] = [:]
    public var count: Int { return registry.count }

    public init() { }

    public func register<T>(_ constructor: @autoclosure @escaping () -> T) {
        let fullName = String(describing: T.self)
        let target = fullName.components(separatedBy: "->").last!.trimmingCharacters(in: [" "])
        registry[target] = { constructor() }
    }

    public func registerSingleton<T>(_ constructor: @autoclosure @escaping () -> T) {
        let singleton = constructor()
        register(singleton)
    }

    public func resolve<T>() -> T? {
        let fullName = String(describing: T.self)
        if let constructor = registry[fullName] {
            return constructor() as? T
        }
        return nil
    }

    public func resolve<T, U>(_ tuple: (U)) -> T? {
        let fullName = String(describing: T.self)
        if let constructor = registry[fullName] {
            let constructorWithTuple = constructor() as? (U) -> T
            return constructorWithTuple?(tuple)
        }
        return nil
    }

    public func clear() {
        registry = [:]
    }
}

//: [Next](@next)
