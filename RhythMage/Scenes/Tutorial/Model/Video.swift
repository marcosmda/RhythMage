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
        return Video(title: "rhythMage", subtitles: [
            0.0 : "At the top of the icy mountains, there is a very clumsy mage, who always works his magic to different music.",
            9.0 : "He liked the songs so much that he got distracted and never wrote down his new spells.",
            15.0 : "One day, he went to do a new spell that went terribly wrong, and all the spells he remembered came out of his head, floating in different rhythms!",
            26.0: "Thus, his spells were adrift and he was never able to retrieve them alone. He thought it would be impossible to remember them.",
            34.0: "Until you... oh, wait. Where are you?"
        ])
    }
    
}




