//
//  TutorialInstructionView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 27/10/21.
//

import UIKit

enum TutorialInstructionPosition {
    
    case top
    case bottom
    
}


class TutorialInstructionView: UIView {
    
    private let backgroundSubtitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.primary.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .inikaBold(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = .terciary.withAlphaComponent(0.5)
        setupHiearchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHiearchy() {
        addSubview(backgroundSubtitleView)
        backgroundSubtitleView.addSubview(subtitle)
    }
    
    private func setupLayout() {
        
        //MARK: - Subtitle
        subtitle.topAnchor.constraint(equalTo: backgroundSubtitleView.topAnchor, constant: 20).isActive = true
        subtitle.centerXAnchor.constraint(equalTo: backgroundSubtitleView.centerXAnchor).isActive = true
        subtitle.centerYAnchor.constraint(equalTo: backgroundSubtitleView.centerYAnchor).isActive = true
        subtitle.widthAnchor.constraint(equalTo: backgroundSubtitleView.widthAnchor, multiplier: 0.9).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: backgroundSubtitleView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    func setupInteractionSceneView(with view: UIView, text: String, position: TutorialInstructionPosition, from insideView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        subtitle.text = text
        backgroundSubtitleView.centerXAnchor.constraint(equalTo: insideView.centerXAnchor).isActive = true
        backgroundSubtitleView.widthAnchor.constraint(equalTo: insideView.widthAnchor).isActive = true
        
        switch position {
            case .top:
            backgroundSubtitleView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: insideView.frame.height + insideView.frame.height/2).isActive = true
            case .bottom:
            backgroundSubtitleView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -insideView.frame.height + -insideView.frame.height/2).isActive = true
        }
        
        
    }
    
}
