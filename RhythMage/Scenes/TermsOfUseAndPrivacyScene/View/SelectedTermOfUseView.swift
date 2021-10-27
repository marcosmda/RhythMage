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
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .secondary
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = button.frame.size.height / 2
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
        label.text = "terms of use and privacy".uppercased()
        return label
    }()
    
    ///Create the symbol of the terms of use to appear inside the table view
    var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.image = UIImage(systemName: "envelope")
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
        label.font = .inikaBold(ofSize: 25)
        //label.text = "title"
        return label
    }()
    
    ///Create a label for the last updated time of the terms of use to appear inside the table view
    var lastUpdated: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "AAAA"
        label.textColor = .secondary
        label.font = .inika(ofSize: 14)
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
        label.font = .inika(ofSize: 14)
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 0
        label.textAlignment = .left
        //label.text = "terms"
        return label
    }()
    
    ///Create the scroll view of the Terms Of Use View
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        return scroll
    }()

    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        setupBackGround()
        self.addSubview(icon)
        self.addSubview(title)
        self.addSubview(lastUpdated)
        self.addSubview(terms)
        self.addSubview(scrollView)
        setElementsInView()
        setLayoutScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setElementsInView(){
       
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 58),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            icon.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 40),
            icon.bottomAnchor.constraint(equalTo: title.topAnchor ,constant: -16),
            
            
            title.topAnchor.constraint(equalTo: icon.bottomAnchor ,constant: 16),
            title.bottomAnchor.constraint(equalTo: lastUpdated.topAnchor),
            title.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
    
            lastUpdated.topAnchor.constraint(equalTo: title.bottomAnchor),
            lastUpdated.bottomAnchor.constraint(equalTo: terms.topAnchor, constant: -12),
            lastUpdated.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            lastUpdated.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            
            terms.topAnchor.constraint(equalTo: lastUpdated.bottomAnchor, constant: 12),
            terms.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            terms.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            
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
