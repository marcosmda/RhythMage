//
//  Haptics.swift
//  Eyes
//
//  Created by Lucas Frazão on 13/11/20.
//

import UIKit

let haptic = Haptic()

class Haptic {
    
    public func setupImpactHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    public func setupNotificationHaptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
}
