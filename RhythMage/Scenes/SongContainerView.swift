//
//  SongContainerView.swift
//  RhythMage
//
//  Created by Juliana Prado on 14/10/21.
//

import UIKit

class SongContainerView:UIView {
    
    var highestScore = 0.0
    
    ///icon with the play symbol
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "play.circle.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    ///highest score label
    private let backgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    ///highest score label
    private let highestScoreLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Inika-Bold", size: 15)
        label.numberOfLines = 1
        return label
    }()
    ///Song title Label
    private let songTitleLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Inika-Bold", size: 18)
        label.numberOfLines = 1
        return label
    }()
    ///Artist Name Label
    private let artistNameLabel: DynamicLabel = {
       let label = DynamicLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Inika", size: 15)
        label.numberOfLines = 1
        return label
    }()
    ///StackView containing the Labels
    var labelsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
       
        highestScoreLabel.text = "Highest Score: "+String(highestScore)
        songTitleLabel.text = "Hello"
        artistNameLabel.text = "Adele"
        
        backgroundView.backgroundColor = .red
        setupHiararchy()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        let height: CGFloat = self.frame.size.height//backgroundView.frame.size.height
        let xPosition: CGFloat = self.frame.size.width - 24
        let imageSize: CGFloat = 36
        iconImageView.frame = CGRect(x: (xPosition - imageSize), y: (height - imageSize) / 2, width: imageSize, height: imageSize)
        
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            labelsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            labelsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 10),
    
//            iconImageView.widthAnchor.constraint(equalToConstant: 22),
//            iconImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor),
])
    }
    
    func setupHiararchy(){
        
        self.addSubview(backgroundView)
        labelsStackView.addArrangedSubview(highestScoreLabel)
        labelsStackView.addArrangedSubview(songTitleLabel)
        labelsStackView.addArrangedSubview(artistNameLabel)
        backgroundView.addSubview(labelsStackView)
        backgroundView.addSubview(iconImageView)
    }
    
    //MARK: - Configuration
    ///Prepares the cell to be reused
    func prepareForReuse() {
        highestScoreLabel.text = nil
        songTitleLabel.text = nil
        artistNameLabel.text = nil
    }
    
    ///Configures the cell for usage
    public func configure(with model: Level, and userModel: User){
        artistNameLabel.text = model.artistName.uppercased()
        songTitleLabel.text = model.songName.uppercased()
        if let highest = userModel.completed[model.getId()] {
            highestScore = highest
        }
    
    }
}
