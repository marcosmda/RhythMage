//
//  TermsOfUseScene.swift
//  RhythMage
//
//  Created by Bruna Costa on 26/10/21.
//

import Foundation
import UIKit

class TermsOfUseView: UIView{
    
    var delegate: TermsOfUseDelegate?
    var gradientView = GradientBackgroundView()
    
    ///Create a title of the section of the terms of use to appear in the nav bar
    let titleNavBar: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .inikaBold(ofSize: 25)
        label.contentMode = .scaleAspectFit
        label.text = "terms of use and privacy".uppercased()
        return label
    }()
    
    
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
    
    ///Create the table view of the buttons bellow the haptic button
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TermsOfUseCell.self, forCellReuseIdentifier: TermsOfUseCell.reusableIdentifier)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()

    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        setupBackGround()
        //self.addSubview(scrollView)
        self.addSubview(tableView)
        //setLayoutScrollView()
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   
    
    func setupViews(){
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //contentView.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
         
       }
    
    func setupBackGround(){
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
