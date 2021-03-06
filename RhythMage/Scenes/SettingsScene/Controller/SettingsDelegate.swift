//
//  SettingsDelegate.swift
//  RhythMage
//
//  Created by Bruna Costa on 22/10/21.
//

import Foundation
import UIKit

protocol SettingsDelegate {
    func onBackButtonPush()
    func switchValueDidChange(to value: Bool)
}
