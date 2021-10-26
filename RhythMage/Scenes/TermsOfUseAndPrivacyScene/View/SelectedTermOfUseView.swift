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
    
    ///Create a title of the section of the terms of use to appear in the nav bar
    let titleNavBar: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .inikaBold(ofSize: 25)
        label.contentMode = .scaleAspectFit
        return label
    }()
    
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
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .inikaBold(ofSize: 25)
        return label
    }()
    
    ///Create a label for the last updated time of the terms of use to appear inside the table view
    var lastUpdated: DynamicLabel = {
        let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondary
        label.font = .inika(ofSize: 14)
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 0
        label.textAlignment = .left
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
        return label
    }()

    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(gradientView)
        self.addSubview(icon)
        self.addSubview(title)
        self.addSubview(lastUpdated)
        self.addSubview(terms)
        setupBackGround()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupBackGround(){
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
    }

    
}
