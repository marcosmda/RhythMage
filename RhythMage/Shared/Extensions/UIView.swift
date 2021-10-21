//
//  UIView.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 20/10/21.
//

import UIKit

extension UIView {
    
    func alignToParentView(_ view: UIView, safe: Bool = true) {
        if safe {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
}
