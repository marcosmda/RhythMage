//
//  CheckpointScores.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation

struct CheckpointScores {
    //MARK: - Properties
    /// The first achievable checkpoint.
    let bronze: Double
    /// The second achievable checkpoint.
    let silver: Double
    /// The third achievable checkpoint.
    let gold: Double
    /// The last achievable checkpoint.
    let wizard: Double
    
    //MARK: - Initialization
    init(bronze: Double, silver: Double, gold: Double, wizard: Double) {
        self.bronze = bronze
        self.silver = silver
        self.gold = gold
        self.wizard = wizard
    }
}
