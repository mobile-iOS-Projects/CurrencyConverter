//
//  Withable.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

// Credit: https://github.com/Geri-Borbas/iOS.Package.Withable
// Credit is reference in `Sources/Resources/oss_licenses/config.yml`

// MARK: - Withable for Objects
public protocol ObjectWithable: AnyObject {
    associatedtype SelfType

    /// Provides a closure to configure instances inline.
    /// - Parameter closure: A closure `self` as the argument.
    /// - Returns: Simply returns the instance after called the `closure`.
    @discardableResult
    func with(_ closure: (_ instance: SelfType) -> Void) -> SelfType
}

extension ObjectWithable {
    @discardableResult
    public func with(_ closure: (_ instance: Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: ObjectWithable {}

// MARK: - Withable for Values
public protocol Withable {
    associatedtype SelfType

    /// Provides a closure to configure instances inline.
    /// - Parameter closure: A closure with a mutable copy of `self` as the argument.
    /// - Returns: Simply returns the mutated copy of the instance after called the `closure`.
    @discardableResult
    func with(_ closure: (_ instance: inout SelfType) -> Void) -> SelfType
}

extension Withable {
    @discardableResult
    public func with(_ closure: (_ instance: inout Self) -> Void) -> Self {
        var copy = self
        closure(&copy)
        return copy
    }
}
