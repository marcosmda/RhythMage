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
    var userSettings: UserSettings?

    var gradientView = GradientBackgroundView()
    
    ///Create the rectangle view of the haptic button
    let rectangle: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .terciary.withAlphaComponent(0.4)
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
        label3.minimumScaleFactor = 0.1
        label3.sizeToFit()
        //label3.fitTextToBounds()
        return label3
        
    }()
    
    let cameraImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "CameraAccessSmall")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    ///Create the title that explain the use of the camera
    var explanationCameraText: DynamicLabel = {
        let label3 = DynamicLabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "For playing with your face and registering your best moments, go to Settings and allow Camera Access."
        label3.textColor = .secondary
        label3.numberOfLines = 0
        label3.textAlignment = .center
        label3.font = UIFont(name: "SF Pro Text", size: 14)
        label3.contentMode = .scaleAspectFill
        //label3.minimumScaleFactor = 0.1
        label3.sizeToFit()
        //label3.fitTextToBounds()
        return label3
        
    }()
    
    ///Create the subtitle of the rectangle view with the hapticSwitch
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
    
    
    ///Create the layout of back button on the Navigation Bar
    lazy var backButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        button.backgroundColor = .secondary
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = button.frame.size.height / 2
        button.addTarget(self, action: #selector(onBackButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    ///Create the table view of the buttons bellow the haptic button
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsButtonCell.self, forCellReuseIdentifier: SettingsButtonCell.reusableIdentifier)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        //table.layer.cornerRadius = 20
        return table
    }()
    
    //MARK: - Initializers
    convenience init(frame: CGRect, userSettings: UserSettings){
        
        self.init(frame: frame)
        self.userSettings = userSettings

    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.addSubview(gradientView)
        setupBackGround()
        self.addSubview(rectangle)
        self.addSubview(hapticSwitch)
        self.addSubview(titleText)
        self.addSubview(settingsDescription)
        self.addSubview(tableView)
        self.addSubview(explanationCameraText)
        setupRectangleView()
        self.addSubview(cameraImage)
        setupLayoutTableView()
        setImageAndTextForCamera()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Add autolayout of the rectangle view
    func setupRectangleView(){
        
        NSLayoutConstraint.activate([
            rectangle.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 50),
           rectangle.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            rectangle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
           rectangle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
])
        setupElementsInRectangleView()
        
        ///Add elements to the rectangle view
        rectangle.addSubview(hapticSwitch)
        rectangle.addSubview(titleText)
        rectangle.addSubview(settingsDescription)
    }
    
    ///Add autolayout of the elements inside the rectangle view
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
    
    ///Add autolayout of the tableview
    func setupLayoutTableView(){
        //tableView.backgroundColor = .red
        
       
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 20),
           tableView.bottomAnchor.constraint(equalTo: cameraImage.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -30),
            

        ])
        

    }
    
    func setImageAndTextForCamera(){
        NSLayoutConstraint.activate([
            cameraImage.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            cameraImage.widthAnchor.constraint(lessThanOrEqualToConstant: 180),
            cameraImage.heightAnchor.constraint(lessThanOrEqualToConstant: 180),
            cameraImage.bottomAnchor.constraint(equalTo: explanationCameraText.topAnchor),
            cameraImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            explanationCameraText.topAnchor.constraint(equalTo: cameraImage.bottomAnchor),
            explanationCameraText.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            explanationCameraText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            explanationCameraText.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            explanationCameraText.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func setupBackGround(){
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
    }

    ///Create a action to the back button associated with the delegate
    @objc func onBackButtonPush(){
        delegate?.onBackButtonPush()
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
