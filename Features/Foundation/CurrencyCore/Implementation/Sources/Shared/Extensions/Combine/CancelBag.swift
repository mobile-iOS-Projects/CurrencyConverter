//
//  CancelBag.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Combine

// MARK: - CancelBag

/// A convenient wrapper around a set of AnyCancellable
public class CancelBag {
    public var subscriptions = Set<AnyCancellable>()

    public init() { /* noOP */ }
}

extension CancelBag {
    public func cancelAll() {
        self.subscriptions.forEach { $0.cancel() }
        self.subscriptions.removeAll()
    }
}

extension AnyCancellable {
    public func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
