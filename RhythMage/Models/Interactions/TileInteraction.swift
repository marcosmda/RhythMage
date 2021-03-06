//
//  Tile.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation
import RealmSwift

/// The X area of teh screen where the interactions will scroll.
enum ScreenScrollArea: Int {
    case left = 0
    case middle = 1
    case right = 2
}

class TileInteraction: InteractionProtocol, Codable {
    //MARK: Protocol Properties
    var minimumScore: Double
    
    //MARK: Properties
    /// The area where the tile will scroll.
    let xPosition: Int
    /// The time when the interaction will start within the level.
    let startTime: Double
    /// The time when the interaction will end within the level.
    var endTime: Double
    
    
    init(minimumScore: Double, xPosition: ScreenScrollArea, startTime: Double, endTime: Double){
        self.minimumScore = minimumScore
        self.xPosition = xPosition.rawValue
        self.startTime = startTime
        self.endTime = endTime
    }
    
    init(minimumScore: Double, xPosition: Int, startTime: Double, endTime: Double){
        self.minimumScore = minimumScore
        self.xPosition = xPosition
        self.startTime = startTime
        self.endTime = endTime
    }
}

