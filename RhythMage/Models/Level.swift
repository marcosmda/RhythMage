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
    /// the name of the file
    let fileName: String
    /// the type of the file
    let fileType: String
    
    //MARK: - Initialization
    init(id: String, checkpointScores: CheckpointScores, sequences: [InteractionSequence], song: String, artist: String, fileName: String, fileType: String) {
        self.id = id
        self.checkpointScores = checkpointScores
        self.sequences = sequences
        self.unlocked = false
        self.songName = song
        self.artistName = artist
        self.fileName = fileName
        self.fileType = fileType
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
    
    static func mockedLevel(id: String) -> Level {
        let checkpoint = CheckpointScores(bronze: 200, silver: 350, gold: 500, wizard: 700)
        
        switch id{
        case "level1":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "ColdWater")], song: "ColdWater", artist: "Alan Dal Castagne", fileName: "ColdWater", fileType: "m4a")
            return level
        case "level2":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "AtTheBottomOfInfinity")], song: "At The Bottom Of Infinity", artist: "Alan Dal Castagne", fileName: "AtTheBottomOfInfinity", fileType: "mp3")
            return level
        case "level3":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "Puffs")], song: "Puffs", artist: "Alan Dal Castagne", fileName: "Puffs", fileType: "mp3")
            return level
            
        default:
            let level = Level(id: "level4", checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "fairy-tale-waltz")], song: "fairy-tale-waltz", artist: "misha-02", fileName: "fairy-tale-waltz", fileType: "mp3")
            return level
        }
    }
}
