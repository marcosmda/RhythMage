//
//  SummaryView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class SummaryView: UIView {

    let gradientView = GradientBackgroundView()
    
    let interactionsButtonView = InteractionButtonsView()
    
    lazy var rankingButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .white
        button.setImage(UIImage(named: "podium"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = 20
        //button.addTarget(self, action: #selector(onSettingsButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    lazy var shareButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "square.and.arrow.up",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 21, weight: .bold)), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = 20
        //button.addTarget(self, action: #selector(onSettingsButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        self.addSubview(interactionsButtonView)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupLayout() {
        
        //MARK: - Gradient View Setup
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
        
        //MARK: - Bottom Screen
        interactionsButtonView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        interactionsButtonView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        interactionsButtonView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        interactionsButtonView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        
        
    }
    

}
