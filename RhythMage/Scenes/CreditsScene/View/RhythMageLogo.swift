//
//  RhythMageLogo.swift
//  RhythMage
//
//  Created by Bruna Costa on 11/11/21.
//

import UIKit

class RhythMageLogo: UITableViewCell {
    
    //MARK: - Properties
    static let reusableIdentifier = "RhythMageLogo"
    
    let nameGameTitle: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return imageView
    }()
    
    let creditsText: DynamicLabel = {
        let label1 = DynamicLabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textColor = .secondary
        label1.text = "RHYTHMAGE WAS MADE IN BRAZIL BY HAPPY DEVELOPERS"
        label1.font = .inikaBold(ofSize: 24)
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
        
        contentView.addSubview(nameGameTitle)
        contentView.addSubview(creditsText)
        
        nameGameTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameGameTitle.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        nameGameTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        nameGameTitle.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameGameTitle.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        
        creditsText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        creditsText.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        creditsText.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        creditsText.topAnchor.constraint(equalTo: nameGameTitle.bottomAnchor).isActive = true
        //creditsText.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        creditsText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
}
