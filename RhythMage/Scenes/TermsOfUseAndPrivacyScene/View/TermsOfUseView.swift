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
        button.backgroundColor = .secondary
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = button.frame.size.height / 2
        //button.addTarget(self, action: #selector(onBackButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    ///Create the scroll view of the Terms Of Use View
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        return scroll
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
        self.addSubview(scrollView)
        self.addSubview(tableView)
        setLayoutScrollView()
        setupLayoutTableView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Add autolayout of the tableview
    func setupLayoutTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            

        ])
        

    }
    
    func setLayoutScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
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
    
    @objc func onBackButtonPush(){
        delegate?.onBackButtonPush()
    }
    

}
