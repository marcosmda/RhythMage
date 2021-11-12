//
//  CreditsView.swift
//  RhythMage
//
//  Created by Bruna Costa on 20/10/21.
//

import Foundation
import UIKit

class CreditsView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        setUpView()
        setUpScrollView()
        //scrollViewDidScroll(scrollView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gradientView = GradientBackgroundView()
    
    var delegate: CreditsSceneDelegate?
    
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
        label.text = "CREDITS".uppercased()
        return label
    }()

    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    
    ///Create the table view of the buttons bellow the haptic button
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(RhythMageLogo.self, forCellReuseIdentifier: RhythMageLogo.reusableIdentifier)
        table.register(NoCashLogo.self, forCellReuseIdentifier: NoCashLogo.reusableIdentifier)
        table.register(AutorsCredits.self, forCellReuseIdentifier: AutorsCredits.reusableIdentifier)
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.setContentHuggingPriority(.defaultHigh, for: .vertical)
        table.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 54.00
        //table.isScrollEnabled = false
        //table.layer.cornerRadius = 20
        return table
    }()
    
    
    
    func setUpView(){
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
    }
    
    func setUpScrollView(){
        
       // self.addSubview(scrollView)
        self.addSubview(tableView)
        //scrollView.addSubview(contentView)
        //contentView.addSubview(tableView)
        
        //scrollView.bounces = false
       // tableView.bounces = false
        
        /*
        scrollView.backgroundColor = .red
        contentView.backgroundColor = .blue
        tableView.backgroundColor = .green
        */
        //scrollView.addSubview(tableView)
        
        //scrollView.translatesAutoresizingMaskIntoConstraints = false
        //contentView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        /*
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
       
        contentView.topAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
       
        
        tableView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true */
        //tableView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        //tableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    @objc func onBackButtonPush(){
        delegate?.onBackButtonPush()
    }
  /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            tableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 200)
        }

        if scrollView == self.tableView {
            self.tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
        }
    }*/
}
