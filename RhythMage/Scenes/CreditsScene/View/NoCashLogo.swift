//
//  NoCashLogo.swift
//  RhythMage
//
//  Created by Bruna Costa on 11/11/21.
//

import UIKit

class NoCashLogo: UITableViewCell {
    
    //MARK: - Properties
    static let reusableIdentifier = "NoCashLogo"
    
    let noCashLogo: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "NoCashLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return imageView
    }()
    
    let creditsText: DynamicLabel = {
        let label1 = DynamicLabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textColor = .secondary
        label1.text = "Created By"
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
        
        setupLayout()
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        
        contentView.addSubview(noCashLogo)
        contentView.addSubview(creditsText)
        
        creditsText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        creditsText.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        creditsText.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        creditsText.bottomAnchor.constraint(equalTo: noCashLogo.topAnchor).isActive = true
        creditsText.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        noCashLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        noCashLogo.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        noCashLogo.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        noCashLogo.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85).isActive = true
        noCashLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        

        
        //creditsText.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85).isActive = true
        
    }
}
