//
//  InteractionButtonsView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class InteractionButtonsView: UIView {
    
    var delegate: SummaryDelegate?
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .secondaryBackground
        progressView.progressTintColor = .white
        progressView.layer.cornerRadius = 20
        progressView.clipsToBounds = true
        return progressView
    }()
    
    let smileToPlayTitle: UILabel = {
        let label4 = UILabel(frame: .zero)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "face.smiling.fill")?.withTintColor(.white)
        let imageOffsetY: CGFloat = -2.0
        attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: " ")
        myString.append(attachmentString)
        let myStringAfter = NSMutableAttributedString(string: " Smile to Play Again".uppercased())
        myString.append(myStringAfter)
        label4.attributedText = myString
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.textColor = .white
        label4.numberOfLines = 0
        label4.textAlignment = .center
        label4.font = .inikaBold(ofSize: 20)
        label4.contentMode = .scaleAspectFill
        label4.sizeToFit()
        label4.fitTextToBounds()
        return label4
    }()

    
    let playAgainButton: UIButton = {
        let button3 = UIButton(frame: .zero)
        var songText = " Smile to Play Again"
        button3.translatesAutoresizingMaskIntoConstraints = false
        //button3.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button3.backgroundColor = .secondaryBackground
        button3.setImage(UIImage(systemName: "arrow.clockwise",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 23, weight: .bold)), for: .normal)
        button3.tintColor = .white
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.white, for: .normal)
        button3.titleLabel!.font = .inikaBold(ofSize: 27)
        button3.titleLabel?.adjustsFontSizeToFitWidth = true
        button3.layer.cornerRadius = 20
        return button3
    }()
    
    let buttonSongLibrary: UIButton = {
        let button3 = UIButton(frame: .zero)
        var songText = " Library"
        button3.translatesAutoresizingMaskIntoConstraints = false
        //button3.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        button3.backgroundColor = .white
        button3.setImage(UIImage(systemName: "music.note"), for: .normal)
        button3.tintColor = .label
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.label, for: .normal)
        button3.titleLabel!.font = .inikaBold(ofSize: 20)
        button3.layer.cornerRadius = 20
        return button3
    }()
    
    let menuButton: UIButton = {
        let button3 = UIButton(frame: .zero)
        var songText = " Menu"
        button3.translatesAutoresizingMaskIntoConstraints = false
       // button3.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        button3.backgroundColor = .white
        button3.setImage(UIImage(systemName: "house.fill"), for: .normal)
        button3.tintColor = .label
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.label, for: .normal)
        button3.titleLabel!.font = .inikaBold(ofSize: 20)
        button3.layer.cornerRadius = 20
        return button3
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(progressView)
        progressView.addSubview(smileToPlayTitle)
        addSubview(buttonSongLibrary)
        addSubview(menuButton)
    }
    
    override func layoutSubviews() {
        setupLayout()
    }
    
    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        smileToPlayTitle.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        smileToPlayTitle.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        
        buttonSongLibrary.heightAnchor.constraint(equalTo: progressView.heightAnchor).isActive = true
        buttonSongLibrary.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20).isActive = true
        buttonSongLibrary.leadingAnchor.constraint(equalTo: progressView.leadingAnchor).isActive = true
        buttonSongLibrary.widthAnchor.constraint(equalTo: progressView.widthAnchor, multiplier: 0.46).isActive = true
        buttonSongLibrary.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        menuButton.heightAnchor.constraint(equalTo: progressView.heightAnchor).isActive = true
        menuButton.widthAnchor.constraint(equalTo: buttonSongLibrary.widthAnchor).isActive = true
        menuButton.trailingAnchor.constraint(equalTo: progressView.trailingAnchor).isActive = true
        menuButton.centerYAnchor.constraint(equalTo: buttonSongLibrary.centerYAnchor).isActive = true
        
    }
 

    
}
