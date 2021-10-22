//
//  TestView.swift
//  RhythMage
//
//  Created by Juliana Prado on 22/10/21.
//

import UIKit

class TesteView: UIView {
    
    public var song: SongContainerView
    
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
    
    fileprivate let container: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        return view
    }()
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        self.song = SongContainerView(type: .playingSong)
        self.song.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupHiararchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()

        NSLayoutConstraint.activate([
            ///Constraints - container
//            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.14),
            container.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
//            song.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            song.heightAnchor.constraint(equalTo: container.heightAnchor),
            song.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            song.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            

        ])
    }
    
    func setupHiararchy(){
        self.addSubview(container)
        container.addSubview(song)
    }
    
}
