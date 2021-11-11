//
//  User.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import RealmSwift
import Foundation

//class User {
//    //MARK: Private Properties
//    /// The user's id for reference on database.
//    var id: String
//
//    //MARK: Public Properties
//    /// The user's display name.
//    var name: String
//    /// The level tracker for each song. It stores a dictionary containing the level id as key and the highsocre as value.
//    var completed:[String:Double]
//
//    var settings: UserSettings
//
//    //MARK: - Initialization
//    init(id: String, name: String){
//        self.id = id
//        self.name = name
//        self.completed = [String:Double]()
//        self.settings = UserSettings()
//    }
//
//    //MARK: - Methods
//
//    /// A function to get the user id.
//    /// - Returns: The user's id.
//    func getId() -> String {
//        return id
//    }
//
//    static func empty() -> User{
//        return User(id: "", name: "")
//    }
//
//}

//MARK: - Realm

class User: Object {
    @Persisted var id: String = ""
    @Persisted var name: String = ""
    @Persisted var settings: UserSettings! = UserSettings()
    @Persisted var completed: Map<String, String> = Map<String, String>()
    
    var currentlevel = "level1"
    
    //MARK: Initialization
    convenience init(id: String, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}

