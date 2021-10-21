//
//  PointsView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class PointsView: UIView {

    private var mainStackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var pointsText: DynamicLabel = {
        let label = DynamicLabel()
        label.text = NSLocalizedString("32.256", comment: "User Score")
        label.numberOfLines = 1
        label.font = .inikaBold(ofSize: 96)
        label.textColor = .white
        return label
    }()
    
    private var defaultText: DynamicLabel = {
        let label = DynamicLabel()
        label.text = NSLocalizedString("Magical Points", comment: "Default Text")
        label.numberOfLines = 1
        label.font = .inika(ofSize: 28)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
    private func setupHierarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(pointsText)
        mainStackView.addArrangedSubview(defaultText)
    }
    
    private func setupLayout() {
        mainStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        mainStackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
