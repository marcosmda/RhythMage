//
//  TermsOfUseCell.swift
//  RhythMage
//
//  Created by Bruna Costa on 26/10/21.
//

import Foundation
import UIKit

class TermsOfUseCell:  UITableViewCell{
    
    static let reusableIdentifier = "TermsOfUseCell"
    var delegate: TermsOfUseDelegate?
    
    ///Create the symbol of the terms of use to appear inside the table view
    var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .secondary
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    ///Create a title of the section of the terms of use to appear inside the table view
    var title: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .inikaBold(ofSize: 25)
        return label
    }()
    
    ///Create a sinopse of the terms of use to appear inside the table view
    var sinopse: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.font = .inika(ofSize: 16)
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var button: UIButton = {
        let button3 = UIButton(frame: .zero)
        button3.tintColor = .secondary
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.secondary, for: .normal)
        button3.titleLabel!.font = .inikaBold(ofSize: 20)
        button3.layer.cornerRadius = 20
        button3.backgroundColor = .terciary.withAlphaComponent(0.5)
        return button3
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TermsOfUseCell.reusableIdentifier)
        
        self.backgroundColor = .clear
        contentView.clipsToBounds = false
        accessoryType = .disclosureIndicator
        

        self.addSubview(icon)
        self.addSubview(title)
        self.addSubview(sinopse)
        self.addSubview(button)
        addStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addStackView(){
        
        /// Nested StackView which contains both userInformationStackView and mediaStackView.
        let finalStackView = UIStackView(arrangedSubviews: [icon, title, sinopse, button])
        finalStackView.translatesAutoresizingMaskIntoConstraints = false
        finalStackView.axis = .vertical
        finalStackView.spacing = 12
        
        contentView.addSubview(finalStackView)
        
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 58),
            title.bottomAnchor.constraint(equalTo: sinopse.topAnchor, constant: -12),
            sinopse.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            sinopse.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -12),
            button.topAnchor.constraint(equalTo: sinopse.bottomAnchor, constant: 12),
            button.heightAnchor.constraint(equalToConstant:  56),
        ])

        
        NSLayoutConstraint.activate([
            finalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            finalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            finalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            finalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
    
    
    
}
