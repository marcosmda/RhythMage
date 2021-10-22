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
    case middleLeft = 1
    case middleRight = 2
    case right = 3
}

class TileInteraction: InteractionProtocol {
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

//MARK: - Realm
class RealmTileInteraction: Object {
    @objc dynamic var minimumScore: Double
    @objc dynamic var xPosition: Int
    @objc dynamic var startTime: Double
    @objc dynamic var endTime: Double
    
    required init(minimumScore: Double, xPosition: ScreenScrollArea, startTime: Double, endTime: Double) {
        self.minimumScore = minimumScore
        self.xPosition = xPosition.rawValue
        self.startTime = startTime
        self.endTime = endTime
    }
    
    required init() {
        self.minimumScore = 0
        self.xPosition = 0
        self.startTime = 0
        self.endTime = 0
    }
}
