//
//  LoadingScreenView.swift
//  RhythMage
//
//  Created by Juliana Prado on 13/10/21.
//

import UIKit

class LoadingScreenView: UIView {
    
    var song: SongContainerView
    
    ///progress bar
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .white
        progressView.progressTintColor = .clear
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.layer.borderWidth = 3
        progressView.layer.borderColor = UIColor.white.cgColor
        return progressView
    }()
    
    ///loading label
    private let loadingLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LOADING..."
        label.textColor = .white
        label.font = UIFont(name: "Inika-Bold", size: 25)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    ///tips label
    private let tipsLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Did you know that songs can be unlocked by reaching point milestones?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Inika-Bold", size: 15)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    ///Stack that contains: LoadingLabel, ProgressView and TipsLabel.
    private let loadingPackStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 11
         return stackView
    }()
        
    override init(frame: CGRect) {
        song = SongContainerView()
        song.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        setupHiararchy()
        progressView.setProgress(0.5, animated: false)
        
    }
    
    override func layoutSubviews() {
        
        NSLayoutConstraint.activate([
            song.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            song.heightAnchor.constraint(equalToConstant: 80),
            song.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            song.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            progressView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            progressView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.03),
            
            loadingPackStack.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor),
            loadingPackStack.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            loadingPackStack.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            loadingPackStack.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -103)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setupHiararchy(){
        self.addSubview(song)
        self.addSubview(loadingPackStack)
        loadingPackStack.addArrangedSubview(loadingLabel)
        loadingPackStack.addArrangedSubview(progressView)
        loadingPackStack.addArrangedSubview(tipsLabel)
        
    }
    
}
