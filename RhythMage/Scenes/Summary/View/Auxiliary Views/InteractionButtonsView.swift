//
//  InteractionButtonsView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class InteractionButtonsView: UIView {

//    private var mainStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.distribution = .fill
//        stackView.alignment = .center
//        stackView.spacing = 20
//        return stackView
//    }()
//
//    private var horizontalView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.alignment = .center
//        stackView.spacing = 10
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
    
    let playAgainButton: UIButton = {
        let button3 = UIButton(frame: .zero)
        var songText = " Smile to Play Again"
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button3.backgroundColor = .secondaryBackground
        button3.setImage(UIImage(systemName: "music.note"), for: .normal)
        button3.tintColor = .white
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.white, for: .normal)
        button3.titleLabel!.font = .inikaBold(ofSize: 27)
        button3.titleLabel?.adjustsFontSizeToFitWidth = true
        button3.layer.cornerRadius = 20
        //button3.addTarget(self, action: #selector(onSongLibraryButtonPush), for: .touchUpInside)
        return button3
    }()
    
    let buttonSongLibrary: UIButton = {
        let button3 = UIButton(frame: .zero)
        var songText = " Library"
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        button3.backgroundColor = .white
        button3.setImage(UIImage(systemName: "music.note"), for: .normal)
        button3.tintColor = .label
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.label, for: .normal)
        //TODO: Confirm the colors
        button3.titleLabel!.font = .inikaBold(ofSize: 20)
        button3.layer.cornerRadius = 20
        //button3.addTarget(self, action: #selector(onSongLibraryButtonPush), for: .touchUpInside)
        return button3
    }()
    
    let menuButton: UIButton = {
        let button3 = UIButton(frame: .zero)
        var songText = " Menu"
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        button3.backgroundColor = .white
        button3.setImage(UIImage(systemName: "house.fill"), for: .normal)
        button3.tintColor = .label
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.label, for: .normal)
        //TODO: Confirm the colors
        button3.titleLabel!.font = .inikaBold(ofSize: 20)
        button3.layer.cornerRadius = 20
        //button3.addTarget(self, action: #selector(onSongLibraryButtonPush), for: .touchUpInside)
        return button3
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(playAgainButton)
        addSubview(buttonSongLibrary)
        addSubview(menuButton)
    }
    
    private func setupLayout() {
       self.translatesAutoresizingMaskIntoConstraints = false
        playAgainButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        playAgainButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        playAgainButton.heightAnchor.constraint(lessThanOrEqualToConstant: 54).isActive = true
        //playAgainButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        
        buttonSongLibrary.heightAnchor.constraint(equalTo: playAgainButton.heightAnchor).isActive = true
        buttonSongLibrary.topAnchor.constraint(equalTo: playAgainButton.bottomAnchor, constant: 20).isActive = true
        buttonSongLibrary.leadingAnchor.constraint(equalTo: playAgainButton.leadingAnchor).isActive = true
        buttonSongLibrary.widthAnchor.constraint(equalTo: playAgainButton.widthAnchor, multiplier: 0.45).isActive = true
        buttonSongLibrary.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        menuButton.heightAnchor.constraint(equalTo: playAgainButton.heightAnchor).isActive = true
        menuButton.widthAnchor.constraint(equalTo: playAgainButton.widthAnchor, multiplier: 0.45).isActive = true
        menuButton.trailingAnchor.constraint(equalTo: playAgainButton.trailingAnchor).isActive = true
        menuButton.centerYAnchor.constraint(equalTo: buttonSongLibrary.centerYAnchor).isActive = true
        
    }

}
