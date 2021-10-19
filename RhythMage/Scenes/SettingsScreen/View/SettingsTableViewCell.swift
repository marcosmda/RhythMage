//
//  SettingsTableViewCell.swift
//  RhythMage
//
//  Created by Bruna Costa on 19/10/21.
//

import Foundation
import UIKit

class SettingsTableViewCell: UIView {
    
    let rectangle: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .terciary.withAlphaComponent(0.4)
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var buttonText: UILabel = {
        let label3 = UILabel(frame: .zero)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.textColor = .secondary
        label3.numberOfLines = 0
        label3.textAlignment = .left
        label3.font = .inikaBold(ofSize: 18)
        label3.contentMode = .scaleAspectFill
        label3.minimumScaleFactor = 0.1
        label3.sizeToFit()
        return label3
    }()
    
    let rightChevronImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .secondary
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setTableViewCell(){
        NSLayoutConstraint.activate([
            rectangle.heightAnchor.constraint(lessThanOrEqualToConstant: 56),
            rectangle.widthAnchor.constraint(lessThanOrEqualToConstant: 349)])
        setElementsOfTableViewCell()
        rectangle.addSubview(buttonText)
        rectangle.addSubview(rightChevronImage)
    }
    
    func setElementsOfTableViewCell(){
        NSLayoutConstraint.activate([
            buttonText.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 20),
            buttonText.bottomAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: -20),
            buttonText.centerXAnchor.constraint(equalTo: rectangle.rightAnchor, constant: -50),
            
            rightChevronImage.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 20),
            rightChevronImage.bottomAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: -20),
            //rightChevronImage.centerXAnchor.constraint(equalTo: rectangle.rightAnchor, constant: -50),
            rightChevronImage.trailingAnchor.constraint(equalTo: buttonText.leadingAnchor, constant: 50)])
    }
    
    
}
