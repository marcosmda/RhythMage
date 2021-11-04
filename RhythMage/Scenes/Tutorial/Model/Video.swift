//
//  TutorialVideo.swift
//  RhythMage
//
//  Created by Lucas Frazão on 26/10/21.
//

import UIKit

struct Video {
    
    var title: String
    var subtitles: [Double:String]
    
    static func setOnboarding() -> Video {
        return Video(title: "rhtyhMage", subtitles: [
            0.0 : "At the top of the icy mountains, there is a very clumsy mage, who always works his magic to different music.",
            8.30 : "He liked the songs so much that he got distracted and never wrote down his spells.",
            13.0 : "One day, he went to do a different spell that went terribly wrong, and all the spells he remembered came out of his head, floating in different rhythms!",
            24.0: "Thus, his spells were adrift and he was never able to retrieve them alone. He thought it would be impossible to remember them.",
            32.0: "Until you... oh, wait. Where are you?"
        ])
    }
    
}




