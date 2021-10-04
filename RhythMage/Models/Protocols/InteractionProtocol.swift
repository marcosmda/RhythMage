//
//  InteractionProtocol.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation

/// The protocol for the interactions that will compose the sequences on the levels.
protocol InteractionProtocol {
    /// The minimum score that an interaction have to have.
    var minimumScore: Double { get }
}
