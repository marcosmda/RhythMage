//
//  TextStyles.swift
//  RhythMage
//
//  Created by Lucas Frazão on 18/10/21.
//

import UIKit

extension UIFont {
    
    //MARK: - Fonts
    class func inika(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Inika", size: size) ?? UIFont.systemFont(ofSize: 15)
    }
    
    class func inikaBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Inika-Bold", size: size) ?? UIFont.systemFont(ofSize: 15)
    }
    
}
