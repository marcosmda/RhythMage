//
//  GameSceneDisplayView.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 20/10/21.
//

import UIKit

class GameSceneDisplayView: UIView {
    
    private var pauseRadius: CGFloat {
        return 30
    }
    
    var score: Double = 0
    
    //MARK: - Initialization
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupContraints()
        setupSubViews()
    }
    
    //MARK: - Methods
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupSubViews() {
        addPauseButton()
    }
    
    func addPauseButton() {
        let image = UIImage(systemName: "pause.circle.fill")
        let imageView = UIImageView(image: image)
        
        imageView.tintColor = .white
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    }
}
