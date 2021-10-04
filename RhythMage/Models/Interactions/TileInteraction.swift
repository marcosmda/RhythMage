//
//  Tile.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation

/// The X area of teh screen where the interactions will scroll.
enum ScreenScrollArea {
    case left
    case middle
    case right
}

class TileInteraction: InteractionProtocol {
    //MARK: Protocol Properties
    var minimumScore: Double
    
    //MARK: Properties
    /// The area where the tile will scroll.
    let xPosition: ScreenScrollArea
    /// The time when the interaction will start within the level.
    let startTime: Double
    /// The time when the interaction will end within the level.
    let endTime: Double
    
    
    init(minimumScore: Double, xPosition: ScreenScrollArea, startTime: Double, endTime: Double){
        self.minimumScore = minimumScore
        self.xPosition = xPosition
        self.startTime = startTime
        self.endTime = endTime
    }
}
