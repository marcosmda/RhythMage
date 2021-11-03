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
    
    let rectangle: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .terciary.withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    ///Create a title to appear inside the table view
    let settingLabel: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.font = .inikaBold(ofSize: 18)
        label.contentMode = .scaleAspectFit
        label.sizeToFit()
        label.numberOfLines = 0
        //label.fitTextToBounds()
        //label.minimumScaleFactor = 0.1
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
        
        self.backgroundColor = .clear
        accessoryType = .disclosureIndicator
        self.accessoryType = UITableViewCell.AccessoryType.none
        contentView.clipsToBounds = false
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        
        self.addSubview(rectangle)
        rectangle.addSubview(accessory)
        rectangle.addSubview(settingLabel)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Add autolayout to the UIView Rectangle
    func setupRectangle() {
        
        NSLayoutConstraint.activate([
            rectangle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rectangle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rectangle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            rectangle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    

    ///Add autolayout to the label inside the tableView
    func setupSettingLabel() {
        
        
        NSLayoutConstraint.activate([
            settingLabel.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 20),
            settingLabel.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor),
            settingLabel.centerYAnchor.constraint(equalTo: rectangle.centerYAnchor),
            settingLabel.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 10),
            settingLabel.bottomAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: -10)
        ])
    }
    
    ///Add autolayout to the image inside the tableView
    func setupAccessory() {
        accessory.image = UIImage(systemName: "chevron.right")
        accessory.tintColor = .secondary
        
        NSLayoutConstraint.activate([
            accessory.centerYAnchor.constraint(equalTo: settingLabel.centerYAnchor),
            accessory.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor, constant: -20)
        ])
    }
    
    public func didHighlightButton(){
        rectangle.backgroundColor = .terciary.withAlphaComponent(0.8)
    }
    
    public func didUnhighlightButton(){
        rectangle.backgroundColor = .terciary.withAlphaComponent(0.5)
        
    }

    
    ///Function to call inside the controler to set the objects of the table view
    func setupCell(currentSetting: String) {
        setupRectangle()
        setupSettingLabel()
        setupAccessory()
        settingLabel.text = currentSetting
    }
}

