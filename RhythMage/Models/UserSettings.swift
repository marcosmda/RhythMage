//
//  UseSettings.swift
//  RhythMage
//
//  Created by Bruna Costa on 22/10/21.
//

import Foundation
import RealmSwift

class UserSettings: EmbeddedObject {
    @Persisted var isHapticOn: Bool = true
    @Persisted var isTutorialSoundOn: Bool = true
}

enum UserSettingsKeys: String {
    case isHapticOn = "isHapticOn"
    case isTutorialSoundOn = "isTutorialSoundOn"
}
