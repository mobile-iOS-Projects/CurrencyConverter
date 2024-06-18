//
//  Conversion+Register.swift
//  ConversionAPI
//
//  Created by Siarhei Runovich on 12.06.24.
//

import Factory
import Networking
import Env
import EnvAPI

extension Container {
    var networkingAPI: Factory<NetworkingAPI> {
        self { Networking() }
    }
    
    var networkMonitorAPI: Factory<NetworkMonitorAPI> {
        self { NetworkMonitor() }
    }
}
