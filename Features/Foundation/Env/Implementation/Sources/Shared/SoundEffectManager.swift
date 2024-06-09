import AudioToolbox
import AVKit
import CoreHaptics
import UIKit
import EnvAPI

public class SoundEffectManager: SoundEffectManagerAPI {

    private var systemSoundIDs: [SoundEffect: SystemSoundID] = [:]

    public init() {
        registerSounds()
    }

    private func registerSounds() {
        SoundEffect.allCases.forEach { effect in
            guard let url = Bundle.main.url(forResource: effect.rawValue, withExtension: "wav") else {
                return
            }
            register(url: url, for: effect)
        }
    }

    private func register(url: URL, for effect: SoundEffect) {
        var soundId: SystemSoundID = .init()
        AudioServicesCreateSystemSoundID(url as CFURL, &soundId)
        systemSoundIDs[effect] = soundId
    }

    @MainActor
    public func playSound(_ effect: SoundEffect) {
        guard let soundId = systemSoundIDs[effect] else { return }

        AudioServicesPlaySystemSound(soundId)
    }
}
