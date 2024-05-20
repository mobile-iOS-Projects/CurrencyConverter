//
//  Initials.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

@propertyWrapper
public struct Initials<Value: StringProtocol> {
    private var value: Value

    public var wrappedValue: Value {
        get { value.count <= 3 ? self.value : "" }
        set { value = newValue }
    }

    public init(wrappedValue value: Value) {
        self.value = value
    }
}
