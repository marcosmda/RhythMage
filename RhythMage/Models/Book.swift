//
//  Book.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation

class Book {
    //MARK: Private Properties
    /// The book's id for reference on database.
    private let id: String
    
    //MARK: Public Properties
    /// The pages in the book, they are the different levels inside a saga.
    let pages: [Level]
    
    //MARK: - Initialization
    init(id: String, pages: [Level]) {
        self.id = id
        self.pages = pages
    }
}
