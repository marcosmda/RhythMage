//
//  UINavigationController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 27/10/21.
//

import UIKit

///Extension used to be able to pop to a specific ViewController
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
