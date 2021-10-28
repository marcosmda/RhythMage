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
    
    lazy var bottomMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "this game is better experienced with sound and headphones on".uppercased()
        label.font = .inikaBold(ofSize: 25)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Mage Image
    let cameraAccessImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "headphone")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(gradientView)
        addSubview(bottomMessage)
        addSubview(cameraAccessImage)
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
        
        cameraAccessImage.widthAnchor.constraint(equalTo: self.bottomMessage.widthAnchor).isActive = true
        cameraAccessImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cameraAccessImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        
        bottomMessage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        bottomMessage.topAnchor.constraint(equalTo: self.cameraAccessImage.bottomAnchor).isActive = true
        bottomMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }

}
