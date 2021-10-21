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
    /// Name of the song.
    var songName: String
    /// Name of the artist.
    var artistName: String
    
    //MARK: - Initialization
    init(id: String, checkpointScores: CheckpointScores, sequences: [InteractionSequence], song: String, artist: String) {
        self.id = id
        self.checkpointScores = checkpointScores
        self.sequences = sequences
        self.unlocked = false
        self.songName = song
        self.artistName = artist
    }
    
    //MARK: - Methods
    /// Unlocks the level so the user can play it.
    func unlock() {
        self.unlocked = true
    }
    
    ///Get status of level
    func getUnlock() ->Bool {
        return self.unlocked
    }
    
    /// Gets level id.
    func getId() ->String {
        return self.id
    }
    
    /// Gets level song name.
    func getSongName() ->String {
        return self.songName
    }
    
    static func mockedLevel() -> Level {
        let checkpoint = CheckpointScores(bronze: 200, silver: 350, gold: 500, wizard: 700)
        let level = Level(id: "111", checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction()], song: "fairy-tale-waltz", artist: "AudioJungle")
        
        return level
    }
}
