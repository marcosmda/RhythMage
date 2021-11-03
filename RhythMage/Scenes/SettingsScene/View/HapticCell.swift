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
        switchHapitc.tintColor = .terciary
        switchHapitc.onTintColor = .terciary
        switchHapitc.thumbTintColor = .primary
        switchHapitc.backgroundColor = .terciary
        switchHapitc.layer.cornerRadius = switchHapitc.frame.size.height / 2
        switchHapitc.layer.masksToBounds = true
        switchHapitc.addTarget(self, action: #selector(switchValueDidChange(_ :)), for: .valueChanged)
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
        label4.numberOfLines = 0
        label4.textAlignment = .left
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
        rectangle.addSubview(titleText)
        rectangle.addSubview(settingsDescription)
        
        setupElementsInRectangleView()
    }
    
    ///Add autolayout of the elements inside the rectangle view
    func setupElementsInRectangleView(){
        NSLayoutConstraint.activate([
        hapticSwitch.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 20),
        hapticSwitch.centerXAnchor.constraint(equalTo: rectangle.rightAnchor, constant: -50),
        
        titleText.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 10),
        titleText.bottomAnchor.constraint(equalTo: settingsDescription.topAnchor),
        titleText.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor),
        titleText.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 20),
        
        settingsDescription.topAnchor.constraint(equalTo: titleText.bottomAnchor),
        settingsDescription.bottomAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: -10),
        settingsDescription.trailingAnchor.constraint(equalTo: hapticSwitch.leadingAnchor),
        settingsDescription.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 20),
        
        ])
        
    }
    
    func setupCell() {
        setupRectangleView()  
    }
    
    ///Create a action to the haptic switch button associated with the delegate
    @objc func switchValueDidChange(_ sender: UISwitch)
    {
        delegate?.switchValueDidChange()
        if (sender.isOn == true)
        {
            userSettings?.isHapticOn = true
        }
        else
        {
            userSettings?.isHapticOn = false
        }
           

    }
    
    
}
