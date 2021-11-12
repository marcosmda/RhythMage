//
//  CreditsModel.swift
//  RhythMage
//
//  Created by Bruna Costa on 11/11/21.
//

import UIKit

struct CreditsData{
    
    var title:String
    var creators:String
}

class CreditsModel {
    
    var data: [CreditsData] = [
    CreditsData(title: "Design", creators: "LUCAS FRAZÃO\nVICTOR DUARTE"),
    CreditsData(title: "Programing", creators: "BRUNA COSTA\nLUCAS FRAZÃO\nJULIANA PRADO\nMARCOS MAJEVSKI"),
    CreditsData(title: "Initial Concept Art", creators: "BRUNA COSTA\nLUCAS FRAZÃO\nVICTOR DUARTE"),
    CreditsData(title: "Logo Design", creators: "LUCAS FRAZÃO\nVICTOR DUARTE"),
    CreditsData(title: "Animations", creators: "BRUNA COSTA\nLUCAS FRAZÃO\nJULIANA PRADO\nMARCOS MAJEVSKI\nVICTOR DUARTE"),
    CreditsData(title: "Introduction Video Editing", creators: "VICTOR DUARTE"),
    CreditsData(title: "Introduction Video Voice", creators: "VICTOR DUARTE"),
    CreditsData(title: "Introduction Video Song by", creators: "ZAPSPLAT.COM"),
    ]
}
