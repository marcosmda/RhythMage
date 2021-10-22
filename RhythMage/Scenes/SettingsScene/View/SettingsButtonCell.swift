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
    
    ///Create a title to appear inside the table view
    let settingLabel: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.font = .inikaBold(ofSize: 18)
        return label
    }()
    
    ///Create the symbol to appear inside the table view
    let accessory: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SettingsButtonCell.reusableIdentifier)
        
        self.backgroundColor = .terciary.withAlphaComponent(0.5)
        contentView.clipsToBounds = false
        accessoryType = .disclosureIndicator
        self.addSubview(accessory)
        self.addSubview(settingLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Add autolayout to the label inside the tableView
    func setupSettingLabel() {
        contentView.addSubview(settingLabel)
        
        
        NSLayoutConstraint.activate([
            settingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            settingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
    
    ///Add autolayout to the image inside the tableView
    func setupAccessory() {
        contentView.addSubview(accessory)
        accessory.image = UIImage(systemName: "chevron.right")
        accessory.tintColor = .secondary
        
        NSLayoutConstraint.activate([
            accessory.centerYAnchor.constraint(equalTo: settingLabel.centerYAnchor),
            accessory.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    ///Function to call inside the controler to set the objects of the table view
    func setupCell(currentSetting: String) {
        setupSettingLabel()
        setupAccessory()
        settingLabel.text = currentSetting
    }
}

