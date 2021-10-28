//
//  SummaryView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class SummaryView: UIView {

    var delegate: SummaryDelegate?
    private var score: Int = 0
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        self.addSubview(interactionsButtonView)
        setupInteractionButtonViewActions()
        self.addSubview(pointsView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    convenience init(with images: [UIImage], points: Int, message: String) {
        self.init(frame: .zero)
        self.score = points
        summaryImageViewCollection = SummaryImageViewCollection(frame: frame, with: images)
        configureSummaryImage()
    }
    
    func configureSummaryImage() {
        self.addSubview(summaryImageViewCollection)
        summaryImageViewCollection.translatesAutoresizingMaskIntoConstraints = false
        summaryImageViewCollection.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 50).isActive = true
        summaryImageViewCollection.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        summaryImageViewCollection.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        pointsView.topAnchor.constraint(equalTo: summaryImageViewCollection.bottomAnchor, constant: 35).isActive = true
    }
    
    //MARK: - Gradient
    let gradientView = GradientBackgroundView()
    
    //MARK: - Views
    lazy var pointsView = PointsView(points: self.score, message: "OH, SO MAGIC!")
    var interactionsButtonView = InteractionButtonsView()
    var summaryImageViewCollection = SummaryImageViewCollection()
    
    lazy var rankingButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .white
        button.setImage(UIImage(named: "Podium"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(onLeaderboardButtonPush), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(onShareButton), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    //MARK: - Setup Button Actions
    @objc func onSongLibraryButtonPush(_ sender: UIButton) {
        delegate?.goToSongLibrary()
    }
    @objc func onMenuButtonPush(_ sender: UIButton) {
        delegate?.goToMainMenu()
    }
    
    @objc func onLeaderboardButtonPush(_ sender: UIButton) {
        delegate?.goToLeaderboards()
    }
    
    @objc func onShareButton(_ sender: UIButton) {
        //MARK: - TO-DO: Add Share func!
        delegate?.goToLeaderboards()
    }
    
    //MARK: - SetupInteractionButtons
    func setupInteractionButtonViewActions() {
        self.interactionsButtonView.buttonSongLibrary.addTarget(self, action: #selector(onSongLibraryButtonPush), for: .touchUpInside)
        self.interactionsButtonView.menuButton.addTarget(self, action: #selector(onMenuButtonPush), for: .touchUpInside)
    }
    
    func setupLayout() {
        
        //MARK: - Gradient View Setup
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
        
        //MARK: - Points View
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        
        pointsView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pointsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        //MARK: - Bottom Screen
        interactionsButtonView.translatesAutoresizingMaskIntoConstraints = false
        interactionsButtonView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -30).isActive = true
        interactionsButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        interactionsButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
    }
    

}
