//
//  Level.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation

class Level {
    //MARK: Private Properties
    /// The level's id for reference on database.
    private var id: String
    
    //MARK: Public Properties
    /// The score checkpoints for the level.
    var checkpointScores: CheckpointScores
    /// The sequences of interactions that will compose the gameplay.
    var sequences: [InteractionSequence]
    /// The boolean describing if the level is unlocked for the user or not.
    var unlocked: Bool
    
    //MARK: - Initialization
    init(id: String, checkpointScores: CheckpointScores, sequences: [InteractionSequence]) {
        self.id = id
        self.checkpointScores = checkpointScores
        self.sequences = sequences
        self.unlocked = false
    }
    
    //MARK: - Methods
    /// Unlocks the level so the user can play it.
    func unlock() {
        self.unlocked = true
    }
}
