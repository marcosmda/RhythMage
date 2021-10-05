//
//  DynamicLabel.swift
//  Cultive
//
//  Created by Lucas Frazão on 22/06/21.
//

import UIKit

/// DynamicLabel is a subclass of UILabel that offers native support for DynamicType and Content Sizing by Category
class DynamicLabel: UILabel {
    
    // MARK:- Initializer
    /// Iniatializes a new subclass of UILabel
    /// - Parameter frame: The parameter should be set to zero to be later added as a constraint
    override init(frame: CGRect) {
        super.init(frame: .zero)
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
