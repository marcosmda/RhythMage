//
//  TermsOfUseModel.swift
//  RhythMage
//
//  Created by Bruna Costa on 27/10/21.
//

import Foundation
import UIKit

struct ViewDataModel{
    
    var termsImage: String
    var termsTitle: String
    var termsUpdated: String
    var termsText: String
    
}

class TermsOfUseViewModel{
    
    var data: [ViewDataModel] = [
    
        ViewDataModel(termsImage: "shield.lefthalf.fill",
                      termsTitle: "privacy policy",
                      termsUpdated: "Last updated: October 22, 2021",
                      termsText: <#T##String#>),
        ViewDataModel(termsImage: "character.book.closed.fill",
                      termsTitle: "Interpretation &\nDefinitions",
                      termsUpdated: "Last updated: October 22, 2021",
                      termsText: <#T##String#>),
        ViewDataModel(termsImage: "person.circle",
                      termsTitle: "Collecting & Using\nYour Personal Data",
                      termsUpdated: "Last updated: October 22, 2021",
                      termsText: <#T##String#>),
        ViewDataModel(termsImage: "folder.badge.person.crop",
                      termsTitle: "Disclosure of Your\nPersonal Data",
                      termsUpdated: "Last updated: October 22, 2021",
                      termsText: <#T##String#>),
        ViewDataModel(termsImage: "globe",
                      termsTitle: "Access of the Services ",
                      termsUpdated: "Last updated: October 22, 2021",
                      termsText: <#T##String#>),
        ViewDataModel(termsImage: "envelope",
                      termsTitle: "Contact Us",
                      termsUpdated: "Last updated: October 22, 2021",
                      termsText: <#T##String#>),
    ]
    
}
