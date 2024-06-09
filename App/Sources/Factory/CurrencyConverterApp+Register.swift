//
//  CurrencyConverterApp+Register.swift
//  App
//
//  Created by Siarhei Runovich on 24.05.24.
//

import Factory
import Networking
import EnvAPI
import Env

extension Container {
    var networkingAPI: Factory<NetworkingAPI> {
        self { Networking() }
    }

    var soundEffectManagerAPI: Factory<SoundEffectManagerAPI> {
        self { SoundEffectManager() }
    }
}
