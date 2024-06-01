//
//  PowerOperator.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

precedencegroup ExponentiativePrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiativePrecedence

/// Exponent operator.
public func ** <N: BinaryInteger>(base: N, power: N) -> N {
    N.self(pow(Double(base), Double(power)))
}

/// Exponent operator.
public func ** <N: BinaryFloatingPoint>(base: N, power: N) -> N {
    N.self(pow(Double(base), Double(power)))
}

infix operator **=: AssignmentPrecedence

public func **= <N: BinaryInteger>(lhs: inout N, rhs: N) {
    lhs = lhs ** rhs
}

public func **= <N: BinaryFloatingPoint>(lhs: inout N, rhs: N) {
    lhs = lhs ** rhs
}
