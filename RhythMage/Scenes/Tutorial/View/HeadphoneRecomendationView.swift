//
//  HeadphoneRecomendationView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 26/10/21.
//

import UIKit

struct RecomendationSceneModel {
    
    var message: String
    var image: String
    var showsTopMessage: Bool
    
}


class HeadphoneRecomendationView: UIView {

    let gradientView = GradientBackgroundView()
    var transitionTimer: Timer?
    private var isReadyToSegue: Bool = false
    
    var selection = 0
    
    let headphoneScene = RecomendationSceneModel(message: "WITH SOUND AND HEADPHONES ON", image: "headphone", showsTopMessage: true)
    let lightScene = RecomendationSceneModel(message: "IN BRIGHT ENVIRONMENTS", image: "light", showsTopMessage: true)
    let phoneScene = RecomendationSceneModel(message: "REQUIRES DEVICES WITH TrueDepth Camera️", image: "phone", showsTopMessage: false)
    
    var timer: Timer?
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
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
    
    //MARK: - Mage Image
    let mainImage: UIImageView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
    
        timer = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(handleViewOrder), userInfo: nil, repeats: true)
        
    }
    
    func setupSubviews() {
        addSubview(gradientView)
        addSubview(stackView)
        addSubview(topMessage)
        stackView.addArrangedSubview(mainImage)
        stackView.addArrangedSubview(middleMessage)
    }
    
    
    @objc func handleViewOrder() {
        
        print(selection)
        
        if selection == 0 {
                handleViewComponents(scene: self.headphoneScene)
        } else if (selection == 1) {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.transitionCrossDissolve]) {
                self.handleViewComponents(scene: self.lightScene)
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.transitionCrossDissolve]) {
                self.handleViewComponents(scene: self.phoneScene)
            }
        }
        
        selection += 1
        
        if selection >= 3 {
            timer?.invalidate()
        }
    }
    
    private func handleViewComponents(scene: RecomendationSceneModel) {
        mainImage.image = UIImage(named: scene.image)
        middleMessage.text = scene.message
        
        if scene.showsTopMessage == false {
            topMessage.removeFromSuperview()
        }
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupLayout() {
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
        
        topMessage.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        topMessage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        topMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    }

}
