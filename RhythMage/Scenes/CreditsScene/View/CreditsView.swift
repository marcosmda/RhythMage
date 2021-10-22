//
//  CreditsView.swift
//  RhythMage
//
//  Created by Bruna Costa on 20/10/21.
//

import Foundation
import UIKit

class CreditsView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        self.addSubview(creditsText)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gradientView = GradientBackgroundView()
    
    var delegate: CreditsSceneDelegate?
    
    lazy var backButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = button.frame.size.height / 2
        button.addTarget(self, action: #selector(onBackButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    let creditsText: DynamicLabel = {
        let label1 = DynamicLabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textColor = .secondary
        label1.text = "THIS GAME WAS MADE IN BRAZIL BY (NOT SO) HAPPY DEVELOPERS"
        label1.font = .inikaBold(ofSize: 25)
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.contentMode = .scaleAspectFit
        label1.adjustsFontSizeToFitWidth = true
        return label1
    }()
    
    func setUpView(){
        creditsText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        creditsText.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        creditsText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        creditsText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()

    }
    
    @objc func onBackButtonPush(){
        delegate?.onBackButtonPush()
    }
}
