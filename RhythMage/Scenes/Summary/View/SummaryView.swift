//
//  SummaryView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class SummaryView: UIView {

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        self.addSubview(interactionsButtonView)
        self.addSubview(pointsView)
        self.addSubview(summaryImageViewCollection)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //MARK: - Gradient
    let gradientView = GradientBackgroundView()
    
    //MARK: - Views
    let pointsView = PointsView()
    let interactionsButtonView = InteractionButtonsView()
    var summaryImageViewCollection = SummaryImageViewCollection(frame: .zero, with: ["UserPhoto-Test", "UserPhoto-Test", "UserPhoto-Test"])
    
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
    
    func setupLayout() {
        
        //MARK: - Gradient View Setup
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
        
        //MARK: - Summary Image
        summaryImageViewCollection.translatesAutoresizingMaskIntoConstraints = false
        summaryImageViewCollection.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 50).isActive = true
        summaryImageViewCollection.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        summaryImageViewCollection.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        
        //MARK: - Points View
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.topAnchor.constraint(equalTo: summaryImageViewCollection.bottomAnchor, constant: 35).isActive = true
        pointsView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pointsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        //MARK: - Bottom Screen
        interactionsButtonView.translatesAutoresizingMaskIntoConstraints = false
        interactionsButtonView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -30).isActive = true
        interactionsButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        interactionsButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true  
    }
    

}
