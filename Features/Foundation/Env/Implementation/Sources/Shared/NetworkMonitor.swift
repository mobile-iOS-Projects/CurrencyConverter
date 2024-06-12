//
//  NetworkMonitor.swift
//  Env
//
//  Created by Siarhei Runovich on 12.06.24.
//

import Foundation
import Network
import EnvAPI

@Observable
final public class NetworkMonitor: NetworkMonitorAPI {    
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    public var isConnected = false
    
    public init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}
