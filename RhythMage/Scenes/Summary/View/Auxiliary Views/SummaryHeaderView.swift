//
//  SummaryHeaderView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit
import SpriteKit

class SummaryHeaderView: UIView {

    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
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
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private var songText: DynamicLabel = {
        let label = DynamicLabel()
        label.text = NSLocalizedString("Happier Than Ever", comment: "Song Title").uppercased()
        label.numberOfLines = 1
        label.font = .inikaBold(ofSize: 18)
        label.textColor = .white
        label.contentMode = .scaleAspectFit
        return label
    }()
    /*
    private var artistText: DynamicLabel = {
        let label = DynamicLabel()
        label.text = NSLocalizedString("Billie Eilish", comment: "")
        label.numberOfLines = 1
        label.font = .inika(ofSize: 14)
        label.textColor = .white
        label.contentMode = .scaleAspectFit
        return label
    }()*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        self.mainStackView.contentMode = .scaleAspectFill
        self.mainStackView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, songText: String, artistText: String) {
        self.init(frame: frame)
        self.frame = .zero
        //self.artistText.text = artistText
        self.songText.text = songText.uppercased()
    }
    
    func setupHierarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(defaultLabel)
        mainStackView.addArrangedSubview(songText)
        //mainStackView.addArrangedSubview(artistText)
    }
    
    func setupLayout() {
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        //mainStackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        //mainStackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
       
    }
    
}
