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
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "ColdWater")], song: "Cold Water", artist: "Alan Dal Castagne", fileName: "ColdWater", fileType: "m4a")
            return level
        case "level2":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "AtTheBottomOfInfinity")], song: "At The Bottom Of Infinity", artist: "Alan Dal Castagne", fileName: "AtTheBottomOfInfinity", fileType: "mp3")
            return level
        case "level3":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "Puffs")], song: "Puffs", artist: "Alan Dal Castagne", fileName: "Puffs", fileType: "mp3")
            return level
        case "level4":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "Winds")], song: "Winds", artist: "Alan Dal Castagne", fileName: "Winds", fileType: "m4a")
            return level
        case "level5":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "BavarianGoat")], song: "Bavarian Goat", artist: "Tim Beek", fileName: "BavarianGoat", fileType: "mp3")
            return level
        case "level6":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "Electricbuzz")], song: "Electricbuzz", artist: "Fred Patry", fileName: "Electricbuzz", fileType: "mp3")
            return level
        case "level7":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "ElectronicWave")], song: "Electronic Wave", artist: "Alan Dal Castagne", fileName: "ElectronicWave", fileType: "mp3")
            return level
        case "level8":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "FinallyHappy")], song: "Finally Happy", artist: "Tim Beek", fileName: "FinallyHappy", fileType: "mp3")
            return level
        case "level9":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "HopefulProposition")], song: "Hopeful Proposition", artist: "Fred Patry", fileName: "HopefulProposition", fileType: "mp3")
            return level
        case "level10":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "HumbleBeginning")], song: "Humble Beginning", artist: "Fred Patry", fileName: "HumbleBeginning", fileType: "mp3")
            return level
        case "level11":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "JingleBells")], song: "Jingle Bells", artist: "Tim Beek", fileName: "JingleBells", fileType: "mp3")
            return level
        case "level12":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "LittleApprentice")], song: "Little Apprentice", artist: "Fred Patry", fileName: "LittleApprentice", fileType: "mp3")
            return level
        case "level13":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "MondayMorning")], song: "Monday Morning", artist: "Tim Beek", fileName: "MondayMorning", fileType: "mp3")
            return level
        case "level14":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "NewCitySameSity")], song: "New City Same Sity", artist: "Fred Patry", fileName: "NewCitySameSity", fileType: "mp3")
            return level
        case "level15":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "TenseBoggie")], song: "Tense Boggie", artist: "Fred Patry", fileName: "Tense Boggie", fileType: "mp3")
            return level
        case "level16":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "ThisIsIt")], song: "This Is It", artist: "Fred Patry", fileName: "ThisIsIt", fileType: "mp3")
            return level
        case "level17":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "TrapAndBoss")], song: "Trap And Boss", artist: "Fred Patry", fileName: "TrapAndBoss", fileType: "mp3")
            return level
        case "level18":
            let level = Level(id: id, checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "TryandSolveThis")], song: "Tryand Solve This", artist: "Tim Beek", fileName: "TryandSolveThis", fileType: "mp3")
            return level
        default:
            let level = Level(id: "level4", checkpointScores: checkpoint, sequences: [InteractionSequence.mockedInteraction(fileName: "fairy-tale-waltz")], song: "fairy-tale-waltz", artist: "misha-02", fileName: "fairy-tale-waltz", fileType: "mp3")
            return level
        }
    }
}
