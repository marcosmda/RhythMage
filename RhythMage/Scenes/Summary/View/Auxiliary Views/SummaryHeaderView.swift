//
//  SummaryHeaderView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class SummaryHeaderView: UIView {

    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var defaultLabel: DynamicLabel = {
        let label = DynamicLabel()
        label.text = NSLocalizedString("Your Perfomance For", comment: "Default Text for Summary")
        label.numberOfLines = 1
        label.font = .inika(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private var songText: DynamicLabel = {
        let label = DynamicLabel()
        label.text = NSLocalizedString("Happier Than Ever", comment: "Song Title").uppercased()
        label.numberOfLines = 1
        label.font = .inikaBold(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private var artistText: DynamicLabel = {
        let label = DynamicLabel()
        label.text = NSLocalizedString("Billie Eilish", comment: "Artist")
        label.numberOfLines = 1
        label.font = .inika(ofSize: 14)
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
    
    func setupHierarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(defaultLabel)
        mainStackView.addArrangedSubview(songText)
        mainStackView.addArrangedSubview(artistText)
    }
    
    func setupLayout() {
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
}
