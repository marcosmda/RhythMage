//
//  SettingsView.swift
//  RhythMage
//
//  Created by Bruna Costa on 19/10/21.
//

import Foundation
import UIKit
import SwiftUI

class SettingsView: UIView{
    
    var delegate: SettingsDelegate?
   

    var gradientView = GradientBackgroundView()


    ///Create the layout of back button on the Navigation Bar
    lazy var backButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(onBackButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    
    ///Create a title of the section of the terms of use to appear in the nav bar
    let titleNavBar: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .inikaBold(ofSize: 25)
        label.contentMode = .scaleAspectFit
        label.text = "Settings".uppercased()
        return label
    }()
    
    ///Create the table view of the buttons bellow the haptic button
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsButtonCell.self, forCellReuseIdentifier: SettingsButtonCell.reusableIdentifier)
        table.register(HapticCell.self, forCellReuseIdentifier: HapticCell.reusableIdentifier)
        table.register(CameraTableViewCell.self, forCellReuseIdentifier: CameraTableViewCell.reusableIdentifier)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.setContentHuggingPriority(.defaultHigh, for: .vertical)
        table.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 54.00
        //table.layer.cornerRadius = 20
        return table
    }()
    
    //MARK: - Initializers
    override init(frame:CGRect){
        super.init(frame: frame)
        self.addSubview(gradientView)
        setupBackGround()
        self.addSubview(tableView)
        setupLayoutTableView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    ///Add autolayout of the tableview
    func setupLayoutTableView(){
       
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
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

}
