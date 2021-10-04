//
//  FaceInteraction.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation

/// The valid expressions for the user to make.
enum FaceExpressionType {
    case jawOpen
    case mouthRight
    case mouthLeft
    case tongueOut
}

class FaceInteraction: InteractionProtocol {
    //MARK: Protocol Properties
    var minimumScore: Double
    
    //MARK: Properties
    /// The expression that the user have to do.
    let expression: FaceExpressionType
    /// The maximum duration before the interaction fails and a new one shows.
    let maxDuration: Double
    
    init(minimumScore: Double, expression: FaceExpressionType, maxDuration: Double) {
        self.minimumScore = minimumScore
        self.expression = expression
        self.maxDuration = maxDuration
    }
}
