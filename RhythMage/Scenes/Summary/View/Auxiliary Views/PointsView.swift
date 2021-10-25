//
//  PointsView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class PointsView: UIView {

    private var points: Int?
    private var message: String?
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var pointsText: DynamicLabel = {
        let label = DynamicLabel()
        label.numberOfLines = 1
        label.font = .inikaBold(ofSize: 96)
        label.textColor = .white
        return label
    }()
    
    private lazy var defaultText: DynamicLabel = {
        let label = DynamicLabel()
        
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
    
    convenience init(points: Int, message: String) {
        self.init(frame: .zero)
        self.points = points
        pointsText.text = NSLocalizedString("\(self.points ?? 0)", comment: "User Score")
        self.message = message
        defaultText.text = NSLocalizedString(self.message ?? "No Message", comment: "Default Text")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
