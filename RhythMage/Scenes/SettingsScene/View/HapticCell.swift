//
//  HapticCell.swift
//  RhythMage
//
//  Created by Bruna Costa on 28/10/21.
//

import Foundation
import UIKit

class HapticCell: UITableViewCell{
    
    
    var delegate: SettingsDelegate?
    var userSettings: UserSettings?
    static let reusableIdentifier = "HapticCell"
    
    ///Create the rectangle view of the haptic button
    let rectangle: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .terciary.withAlphaComponent(0.5)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    ///Create the haptic button
    lazy var hapticSwitch: UISwitch = {
        let switchHapitc = UISwitch()
        switchHapitc.translatesAutoresizingMaskIntoConstraints = false
        switchHapitc.onTintColor = .primary
        switchHapitc.thumbTintColor = .white
        switchHapitc.backgroundColor = .label
        switchHapitc.layer.cornerRadius = switchHapitc.frame.size.height / 2
        switchHapitc.layer.masksToBounds = true
        switchHapitc.addTarget(self, action: #selector(switchValueDidChange(_ :)), for: .valueChanged)
        switchHapitc.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        return switchHapitc
    }()
    
    ///Create the main title of the rectangle view with the hapticSwitch
    lazy var titleText: UILabel = {
        let label3 = UILabel(frame: .zero)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "HAPTIC FEEDBACK"
        label3.textColor = .secondary
        label3.numberOfLines = 0
        label3.textAlignment = .left
        label3.font = .inikaBold(ofSize: 18)
        label3.contentMode = .scaleAspectFill
        return label3
        
    }()
    
    ///Create the subtitle of the rectangle view with the hapticSwitch
    lazy var settingsDescription: UILabel = {
        let label4 = UILabel(frame: .zero)
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.text = "Enables a more immersive experience for RhythMage."
        label4.textColor = .secondary
        label4.numberOfLines = 2
        //label4.lineBreakMode = .byClipping
        label4.textAlignment = .left
        label4.contentMode = .scaleAspectFill
        label4.font = .inika(ofSize: 15)
        return label4
    }()
    
    
    //MARK: - Initializers
    convenience init(frame: CGRect, userSettings: UserSettings){
        
        self.init(frame: frame)
        self.userSettings = userSettings

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: HapticCell.reusableIdentifier)
        
        self.backgroundColor = .clear
        contentView.addSubview(rectangle)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Add autolayout of the rectangle view
    func setupRectangleView(){
        
        NSLayoutConstraint.activate([
            rectangle.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            rectangle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rectangle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rectangle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
        
        
        ///Add elements to the rectangle view
        rectangle.addSubview(hapticSwitch)
        setupElementsInRectangleView()
    }
    
    ///Add autolayout of the elements inside the rectangle view
    func setupElementsInRectangleView(){
        
        let finalStackView = UIStackView(arrangedSubviews: [titleText, settingsDescription])
        finalStackView.translatesAutoresizingMaskIntoConstraints = false
        finalStackView.axis = .vertical
        //finalStackView.spacing = 1
        
        rectangle.addSubview(finalStackView)
        
        NSLayoutConstraint.activate([
        hapticSwitch.centerYAnchor.constraint(equalTo: rectangle.centerYAnchor),
        hapticSwitch.centerXAnchor.constraint(equalTo: rectangle.layoutMarginsGuide.trailingAnchor, constant: -50),
        
        //finalStackView.topAnchor.constraint(equalTo: rectangle.topAnchor),
        finalStackView.centerYAnchor.constraint(equalTo: rectangle.centerYAnchor),
        //finalStackView.bottomAnchor.constraint(equalTo: rectangle.layoutMarginsGuide.bottomAnchor),
        finalStackView.trailingAnchor.constraint(equalTo: hapticSwitch.leadingAnchor, constant: -10),
        finalStackView.leadingAnchor.constraint(equalTo: rectangle.layoutMarginsGuide.leadingAnchor, constant: 10),
        
        ])
        
    }
    
    func setupCell(delegate: SettingsDelegate) {
        self.delegate = delegate
        setupRectangleView()  
    }
    
    ///Create a action to the haptic switch button associated with the delegate
    @objc func switchValueDidChange(_ sender: UISwitch)
    {
        delegate?.switchValueDidChange(to: sender.isOn)
    }
    
    
}
