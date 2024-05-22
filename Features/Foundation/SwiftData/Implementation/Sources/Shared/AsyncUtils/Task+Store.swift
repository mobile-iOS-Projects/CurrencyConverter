//
//  Task+Store.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Combine
import Foundation

extension Task {
    /// Store the tasks cancel action in the given bag
    ///
    /// The task can be cancelled with the given `ID`
    ///
    /// - Parameters:
    ///   - bag: The bag to store the cancel reference in
    ///   - id: Associated ID of the cancel action
    public func store<ID: Hashable>(in bag: TaskBag<ID>, id: ID) async {
        await bag.add(id: id, cancellable: AnyCancellable(cancel))
    }

    /// A cancellable reference of the task
    public var cancellable: AnyCancellable {
        AnyCancellable(self.cancel)
    }
}
