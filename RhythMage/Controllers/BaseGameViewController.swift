//
//  BaseGameViewController.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 07/10/21.
//

import UIKit
import SpriteKit

/// A BaseViewController class that is used to implement new ViewControllers. It is based on a view that is received at init that is the main container of other subviews.
class BaseGameViewController<S: SKScene>: UIViewController {
    
    // MARK:- Properties
    var mainView: SKView
    var mainScene: S
    
    // MARK:- Initializers
    /// Initializes a new ViewController with the provided View.
    /// Parameters:
    ///    - mainView: The View displayed by the ViewController
    /// - Returns: A new ViewController with the provided View.
    init(mainScene: S) {
        self.mainView = SKView(frame: UIScreen.main.bounds)
        self.mainScene = mainScene
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.presentScene(mainScene)
    }

}
