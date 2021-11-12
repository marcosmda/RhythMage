//
//  NoCashLogo.swift
//  RhythMage
//
//  Created by Bruna Costa on 11/11/21.
//

import UIKit

class AutorsCredits: UITableViewCell {
    
    //MARK: - Properties
    static let reusableIdentifier = "AutorsCredits"
    
    var autorsText: DynamicLabel = {
        let label1 = DynamicLabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textColor = .secondary
        label1.font = .inikaBold(ofSize: 24)
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.contentMode = .scaleAspectFit
        label1.adjustsFontSizeToFitWidth = true
        return label1
    }()
    
    var creditsText: DynamicLabel = {
        let label1 = DynamicLabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textColor = .secondary
        label1.font = .inika(ofSize: 18)
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.contentMode = .scaleAspectFit
        label1.adjustsFontSizeToFitWidth = true
        return label1
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: RhythMageLogo.reusableIdentifier)
        
        self.backgroundColor = .clear
        self.addSubview(contentView)
        self.contentView.clipsToBounds = true
        setupLayout()
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        
        contentView.addSubview(autorsText)
        contentView.addSubview(creditsText)
        
        creditsText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        creditsText.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        creditsText.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        creditsText.bottomAnchor.constraint(equalTo: autorsText.topAnchor).isActive = true
        creditsText.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        autorsText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        autorsText.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        autorsText.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        autorsText.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85).isActive = true
        //autorsText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        

        
    }
    ///Function to call inside the controler to set the objects of the table view
    func setupCell(title: String, autor: String) {
        setupLayout()
        creditsText.text = title
        autorsText.text = autor
}
}
