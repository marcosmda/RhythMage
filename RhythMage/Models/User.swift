//
//  User.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation

class User {
    //MARK: Private Properties
    /// The user's id for reference on database.
    private var id: String
    
    //MARK: Public Properties
    /// The user's display name.
    var name: String
    /// The level tracker for each song. It stores a dictionary containing the level id as key and the highsocre as value.
    var completed:[String:Double]
    
    //MARK: - Initialization
    init(id: String, name: String){
        self.id = id
        self.name = name
        self.completed = [String:Double]()
    }
    
    //MARK: - Methods
    
    /// A function to get the user id.
    /// - Returns: The user's id.
    func getId() -> String {
        return id
    }
    
    /// function to set the score of a specific song
    func setCompletedSong(songId: String, songScore: Double){
        if let lastScore = self.completed[songId]{
            if lastScore < songScore{
                self.completed[songId] = songScore
            }
        }
    }
    
    /// A function to get the song highest score.
    /// - Returns: Songs respective highestscore.
    func getHighestscoreCompletedSong(songId: String) -> Double{
        if let songScore = self.completed[songId] {
            return songScore
        } else {
            return 0
        }
    }
    
}
