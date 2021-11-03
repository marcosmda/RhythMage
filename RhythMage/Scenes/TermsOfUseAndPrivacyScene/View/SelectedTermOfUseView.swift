//
//  SelectedTermOfUse.swift
//  RhythMage
//
//  Created by Bruna Costa on 26/10/21.
//

import Foundation
import UIKit

class SelectedTermOfUseView: UIView {
    
    var gradientView = GradientBackgroundView()
    var delegate:SelectedTermsDelegate?
    
    ///Create the layout of back button on the Navigation Bar
    lazy var backButton: UIBarButtonItem = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        button.backgroundColor = .secondary
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = button.frame.size.height / 2
        button.addTarget(self, action: #selector(onBackButtonPushTerms), for: .touchUpInside)
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
        label.text = "terms of use and privacy".uppercased()
        return label
    }()
    
    ///Create the symbol of the terms of use to appear inside the table view
    var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "envelope")
        imageView.tintColor = .secondary
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    ///Create a title of the section of the terms of use to appear inside the table view
    var title: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .inikaBold(ofSize: 24)
        label.text = "title"
        return label
    }()
    
    ///Create a label for the last updated time of the terms of use to appear inside the table view
    var lastUpdated: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "AAAA"
        label.textColor = .secondary
        label.font = UIFont(name: "SF Pro Text", size: 14)
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 0
        label.textAlignment = .left
        //label.text = "lastUpdated"
        return label
    }()
    
    ///Create a sinopse of the terms of use to appear inside the table view
    var terms: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.font = UIFont(name: "SF Pro Text", size: 14)
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 0
        label.textAlignment = .left
        //label.text = "terms"
        return label
    }()
    
    ///Create the scroll view of the Terms Of Use View
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        setupBackGround()
        setupScrollView()
        setupViews()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupScrollView(){
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
        
            self.addSubview(scrollView)
            scrollView.addSubview(contentView)
            
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
    
    
    func setupViews(){
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(terms)
        contentView.addSubview(lastUpdated)
        
        icon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 80).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 80).isActive = true
           
           
        title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 50).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
       
        
        lastUpdated.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        lastUpdated.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        lastUpdated.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        terms.topAnchor.constraint(equalTo: lastUpdated.bottomAnchor, constant: 25).isActive = true
        terms.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        terms.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        terms.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
       }
 
    func setupBackGround(){
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
    }
    
    @objc func onBackButtonPushTerms(){
        delegate?.onBackButtonPushTerms()
    }

    
}
