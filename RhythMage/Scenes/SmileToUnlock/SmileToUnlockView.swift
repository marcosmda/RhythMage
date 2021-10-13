//
//  SmileToUnlockView.swift
//  RhythMage
//
//  Created by Bruna Costa on 09/10/21.
//

import UIKit
import Foundation
import AVFoundation

class SmileToUnlockView: UIView {
    
    var songPlaying:String?
    var bestScore: String?
    public var buttonSelected: Bool = false
    
    var delegate: SmileToUnlockDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Setting the labels of the view
    
    let nameGameTitle: DynamicLabel = {
        let label1 = DynamicLabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textColor = .white
        label1.text = "RYTH\nMAGE"
        label1.shadowColor = .purple
        label1.numberOfLines = 2
        label1.textAlignment = .center
        if let configuration = UIFont(name: "Inika-Bold", size: 75)?.fontDescriptor
        {
            label1.font = UIFontMetrics.default.scaledFont(for: UIFont(descriptor: configuration, size: 75))
        }
        //label1.font = UIFont(name: "Inika-Bold", size: 75)
        label1.contentMode = .scaleAspectFit
        label1.adjustsFontSizeToFitWidth = true
        return label1
    }()
    
    lazy var nameSongTitle: UILabel = {
        let label2 = UILabel(frame: .zero)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.textColor = .white
        label2.text = (songPlaying ?? "Song Playing:")
        label2.numberOfLines = 0
        label2.textAlignment = .center
        label2.font = UIFont(name: "Inika-Bold", size: 18)
        label2.contentMode = .scaleAspectFill
        label2.sizeToFit()
        return label2
        
    }()
    
    lazy var bestScoreTitle: UILabel = {
        let label3 = UILabel(frame: .zero)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.textColor = .white
        label3.text = "Best Score: " + (bestScore ?? "0")
        label3.numberOfLines = 0
        label3.textAlignment = .center
        label3.font = UIFont(name: "Inika-Regular", size: 18)
        label3.contentMode = .scaleAspectFill
        label3.sizeToFit()
        return label3
        
    }()
    
    let smileToPlayTitle: UILabel = {
        let label4 = UILabel(frame: .zero)
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.textColor = .white
        label4.text = ":) SMILE TO PLAY"
        label4.numberOfLines = 0
        label4.textAlignment = .center
        label4.font = UIFont(name: "Inika-Bold", size: 27)
        label4.contentMode = .scaleAspectFill
        label4.sizeToFit()
        return label4
    }()
    
    //Setting the image of the View
    let mageImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Mage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    

    //Setting the Buttons of the view
    let buttonSettings: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 42.71, height: 42.71))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .purple
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.cornerRadius = button.frame.size.width/2
        button.addTarget(self, action: #selector(onSettingsButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    let buttonGameCenter: UIButton = {
        let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 42.71, height: 42.71))
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.backgroundColor = .red
        //TODO: Put the image of the user
        button2.setImage(UIImage(named: "user.profile.pic"), for: .normal)
        button2.imageView?.contentMode = .scaleAspectFit
        button2.layer.cornerRadius = button2.frame.size.width/2
        button2.addTarget(self, action: #selector(onGameCenterButtonPush), for: .touchUpInside)
        button2.clipsToBounds = true
        return button2
    }()
    
    let buttonSongLibrary: UIButton = {
        let button3 = UIButton(frame: .zero)
        button3.backgroundColor = .white
        button3.setImage(UIImage(systemName: "music.note"), for: .normal)
        button3.tintColor = .purple
        button3.setTitle("Library", for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.purple, for: .normal)
        //TODO: Confirm the colors
        button3.titleLabel!.font = UIFont(name: "Inika-Regular", size: 20)
        button3.layer.cornerRadius = 20
        button3.addTarget(self, action: #selector(onSongLibraryButtonPush), for: .touchUpInside)
        return button3
    }()
    
    /*
    func setLayoutBackground(){
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }*/
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //let proportionalStackSpacing = UIScreen.main.bounds.height / 44.8
        
        let buttonsStackView = UIStackView(arrangedSubviews: [buttonSettings, buttonGameCenter])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.backgroundColor = .green
        buttonsStackView.spacing = UIScreen.main.bounds.size.width - (46+46+30+30)
        

        let restStackView = UIStackView(arrangedSubviews: [nameGameTitle, nameSongTitle, bestScoreTitle])
        restStackView.translatesAutoresizingMaskIntoConstraints = false
        restStackView.axis = .vertical
        restStackView.alignment = .center
        restStackView.backgroundColor = .red
        //restStackView.distribution =
        //restStackView.spacing = 20
        
        let finalStackView = UIStackView(arrangedSubviews: [buttonsStackView, restStackView, mageImage, smileToPlayTitle,buttonSongLibrary])
        finalStackView.translatesAutoresizingMaskIntoConstraints = false
        finalStackView.axis = .vertical
        finalStackView.backgroundColor = .brown
        self.addSubview(finalStackView)
 
        NSLayoutConstraint.activate([
            finalStackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor), //constant: 30),
            finalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),//, constant: 1),
            finalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),//, constant: -1),
            finalStackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),//, constant: -1),
        ])
        
        NSLayoutConstraint.activate([

            buttonSettings.widthAnchor.constraint(equalToConstant: 46),
            buttonSettings.heightAnchor.constraint(equalToConstant: 46),
            buttonGameCenter.widthAnchor.constraint(equalToConstant: 46),
            buttonGameCenter.heightAnchor.constraint(equalToConstant: 46),
            buttonSongLibrary.heightAnchor.constraint(equalToConstant: 61),
            
        ])
        //assignbackground()
        
    }
    /*
    func assignbackground(){
        var backgroundView: UIImageView = {
            let bgView = UIImageView(frame: .zero)
            bgView.image = UIImage(named: "background.jpeg")
            bgView.contentMode = .scaleToFill
            bgView.translatesAutoresizingMaskIntoConstraints = false
            return bgView
        }()
        
      }*/
    
    public func requestModel (user: User, level: Level)
    {
        if let bestScore = user.completed[level.getId()]{
            self.bestScore = String(bestScore)
        }
        songPlaying = level.getSongName()
    }
    
    @objc func onSettingsButtonPush(){
        delegate?.onSettingsButtonPush()
        
    }
    
    @objc func onGameCenterButtonPush(){
        delegate?.onGameCenterButtonPush()
    }
    
    @objc func onSongLibraryButtonPush(){
        delegate?.onSongLibraryButtonPush()

            
    }
    
    
    

    
}
