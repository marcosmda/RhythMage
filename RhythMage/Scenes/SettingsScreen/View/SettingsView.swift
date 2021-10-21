//
//  SettingsView.swift
//  RhythMage
//
//  Created by Bruna Costa on 19/10/21.
//

import Foundation
import UIKit

class SettingsView: UIView{
    
    var delegate: SettingsDelegate?
    //var userSettings: UserSettings

    let rectangle: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .terciary.withAlphaComponent(0.4)
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var hapticSwitch: UISwitch = {
        let switchHapitc = UISwitch()
        switchHapitc.translatesAutoresizingMaskIntoConstraints = false
        switchHapitc.tintColor = .terciary
        switchHapitc.onTintColor = .terciary
        switchHapitc.thumbTintColor = .primary
        switchHapitc.backgroundColor = .terciary
        switchHapitc.layer.cornerRadius = 13
        switchHapitc.layer.masksToBounds = true
        switchHapitc.addTarget(self, action: #selector(switchValueDidChange(_ :)), for: .valueChanged)
        return switchHapitc
    }()
    
    lazy var titleText: UILabel = {
        let label3 = UILabel(frame: .zero)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "HAPTIC FEEDBACK"
        label3.textColor = .secondary
        label3.numberOfLines = 0
        label3.textAlignment = .left
        label3.font = .inikaBold(ofSize: 18)
        label3.contentMode = .scaleAspectFill
        label3.minimumScaleFactor = 0.1
        label3.sizeToFit()
        //label3.fitTextToBounds()
        return label3
        
    }()
    
    lazy var settingsDescription: UILabel = {
        let label4 = UILabel(frame: .zero)
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.text = "Settings Description"
        label4.textColor = .secondary
        label4.numberOfLines = 0
        label4.textAlignment = .left
        label4.font = .inika(ofSize: 15)
        label4.contentMode = .scaleAspectFill
        label4.minimumScaleFactor = 0.1
        label4.sizeToFit()
        return label4
        
    }()
    
    lazy var settingsNameBar: UILabel = {
        let label4 = UILabel(frame: .zero)
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.textColor = .secondary.withAlphaComponent(0.5)
        label4.numberOfLines = 0
        label4.textAlignment = .left
        label4.text = "Settings"
        label4.font = .inikaBold(ofSize: 25)
        label4.contentMode = .scaleAspectFill
        label4.minimumScaleFactor = 0.1
        label4.sizeToFit()
        return label4
        
    }()
    
    
    lazy var backButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .secondary
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = button.frame.size.height / 2
        button.addTarget(self, action: #selector(onBackButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsButtonCell.self, forCellReuseIdentifier: SettingsButtonCell.reusableIdentifier)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    override init(frame: CGRect){//}, userSettings: UserSettings) { nao tem override
        //self.userSettings = userSettings

        super.init(frame: frame)
        self.addSubview(rectangle)
        self.addSubview(hapticSwitch)
        self.addSubview(titleText)
        self.addSubview(settingsDescription)
        self.addSubview(tableView)
        setupRectangleView()
        setupLayoutTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupRectangleView(){
        
        NSLayoutConstraint.activate([
            rectangle.topAnchor.constraint(equalTo: self.topAnchor, constant: 130),
           rectangle.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            rectangle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
           rectangle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
])
        setupElementsInRectangleView()
        rectangle.addSubview(hapticSwitch)
        rectangle.addSubview(titleText)
        rectangle.addSubview(settingsDescription)
    }
    
    func setupElementsInRectangleView(){
        NSLayoutConstraint.activate([
        hapticSwitch.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 20),
        hapticSwitch.bottomAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: -20),
        hapticSwitch.centerXAnchor.constraint(equalTo: rectangle.rightAnchor, constant: -50),
        
        titleText.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 10),
        titleText.bottomAnchor.constraint(equalTo: settingsDescription.topAnchor),
        titleText.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor),
        titleText.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 20),
        
        settingsDescription.topAnchor.constraint(equalTo: titleText.bottomAnchor),
        settingsDescription.bottomAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: -10),
        settingsDescription.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor),
        settingsDescription.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 20),
        
        ])
        
    }
    
    func setupLayoutTableView(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -30),

        ])
    }


    @objc func onTermsOfUsePush(){
        delegate?.onTermsOfUsePush()
    }
    @objc func onBackButtonPush(){
        delegate?.onBackButtonPush()
    }
    @objc func onCreditsPush(){
        delegate?.onCreditsPush()
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch)
    {
        delegate?.switchValueDidChange()
        if (sender.isOn == true)
        {
            print("oi")
            //userSettings.isUserHapitcOn = true
        }
        else
        {
            print("tchau")
            //userSettings.isUserHapitcOn = true
        }
           

    }
}
