//
//  SummaryImageSetup.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import Foundation
import UIKit

struct SummaryImageSetup {
    
    var scale: Float
    lazy var rotation: Double = {
        return Double(rotation * Double.pi / 180)
    }()
    
}
