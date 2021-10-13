//
//  BaseGameViewController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 07/10/21.
//

import UIKit
import SpriteKit

/// A BaseViewController class that is used to implement new ViewControllers. It is based on a view that is received at init that is the main container of other subviews.
class BaseGameViewController<V: SKView>: UIViewController {
    
    // MARK:- Properties
    var mainView: V
    
    // MARK:- Initializers
    /// Initializes a new ViewController with the provided View.
    /// Parameters:
    ///    - mainView: The View displayed by the ViewController
    /// - Returns: A new ViewController with the provided View.
    init(mainView: V) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
    }

}
