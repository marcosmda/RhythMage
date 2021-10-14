//
//  InteractionSequence.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation
import RealmSwift

/// The enum describing the type of sequence that will be displayed.
enum SequenceType: Int {
    case face = 0
    case tile = 1
}

/// The sequence of interactions that will compose a sequnce of the gameplay of the level.
class InteractionSequence {
    //MARK: Private Properties
    /// The duration of the sequence computated from each interaction duration.
    private var duration: Double{
        return calculateDuration()
    }
    
    //MARK: Public Properties
    /// The type describing the sequence.
    let type: SequenceType
    /// The sequence of interactions that will compose one part of the level.
    let sequence: [InteractionProtocol]
    
    
    //MARK: - Initialization
    init(type: SequenceType, sequence: [InteractionProtocol]){
        self.type = type
        self.sequence = sequence
    }
    
    //MARK: - Methods
    //TODO: Implementation
    /// Calculates the duration of the complete sequence based on the duration of each interaction.
    /// - Returns: The total duration of the sequence.
    func calculateDuration() -> Double{
        return 0
    }
}

//MARK: - Realm
class RealmInteractionSequence: Object {
    @objc dynamic let type: Int
    
    let sequence = List<RealmTileInteraction>()
    
    required init(){
        self.type = 0
    }
}
