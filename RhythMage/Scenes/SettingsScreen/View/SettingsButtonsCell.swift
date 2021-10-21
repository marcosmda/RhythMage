//
//  SettingsButtonsCell.swift
//  RhythMage
//
//  Created by Bruna Costa on 21/10/21.
//

import Foundation
import UIKit

class SettingsButtonCell:  UITableViewCell{
    
    //MARK: - Properties
    static let reusableIdentifier = "SettingsButtonCell"
    var delegate: SettingsDelegate?
    
    let settingLabel: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.font = .inikaBold(ofSize: 18)
        return label
    }()
    
    let separator: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .terciary
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    
    let accessory: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.tintColor = .secondary
        return imageView
    }()
    
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SettingsButtonCell.reusableIdentifier)
        
        self.backgroundColor = .terciary.withAlphaComponent(0.5)
        contentView.clipsToBounds = false
        accessoryType = .disclosureIndicator
        self.addSubview(accessory)
        self.addSubview(separator)
        self.addSubview(settingLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupSettingLabel() {
        contentView.addSubview(settingLabel)
        
        
        NSLayoutConstraint.activate([
            settingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            settingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
    
    func setupAccessory() {
        contentView.addSubview(accessory)
        accessory.image = UIImage(systemName: "chevron.right")
        accessory.tintColor = .secondary
        
        NSLayoutConstraint.activate([
            accessory.centerYAnchor.constraint(equalTo: settingLabel.centerYAnchor),
            accessory.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    
    func setupCell(currentSetting: String) {
        setupSettingLabel()
        setupAccessory()
        settingLabel.text = currentSetting
    }
}

