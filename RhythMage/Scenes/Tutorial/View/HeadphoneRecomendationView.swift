//
//  HeadphoneRecomendationView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 26/10/21.
//

import UIKit

class HeadphoneRecomendationView: UIView {

    let gradientView = GradientBackgroundView()
    var transitionTimer: Timer?
    private var isReadyToSegue: Bool = false
    
    lazy var topMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "this game is better experienced:".uppercased()
        label.font = .inikaBold(ofSize: 25)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        return stackView
    }()
    
    //MARK: - Mage Image
    let headphoneImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "headphone")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return imageView
    }()
    
    lazy var middleMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "with sound and headphones on".uppercased()
        label.font = .inikaBold(ofSize: 25)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let lightImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "light")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return imageView
    }()
    
    lazy var bottomMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "in bright\nenvironments".uppercased()
        label.font = .inikaBold(ofSize: 25)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(gradientView)
        addSubview(topMessage)
        addSubview(stackView)
        stackView.addArrangedSubview(headphoneImage)
        stackView.addArrangedSubview(middleMessage)
        stackView.addArrangedSubview(lightImage)
        stackView.addArrangedSubview(bottomMessage)
        stackView.setCustomSpacing(15, after: middleMessage)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupLayout() {
        gradientView.setupCircleBackgroundBlur()
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        topMessage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        topMessage.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        topMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        stackView.topAnchor.constraint(lessThanOrEqualTo: self.topMessage.bottomAnchor, constant: 100).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topMessage.bottomAnchor, constant: 70).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
    }

}
