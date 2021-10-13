//
//  SmileToUnlockView.swift
//  RhythMage
//
//  Created by Bruna Costa on 09/10/21.
//

import UIKit
import Foundation
import AVFoundation
import GameplayKit

class SmileToUnlockView: UIView {
    
    var songPlaying:String?
    var bestScore: String?
    public var buttonSelected: Bool = false
    
    var delegate: SmileToUnlockDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assignbackground()
        self.addSubview(nameGameTitle)
        self.addSubview(nameSongTitle)
        self.addSubview(bestScoreTitle)
        self.addSubview(mageImage)
        self.addSubview(smileToPlayTitle)
        self.addSubview(buttonSongLibrary)
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
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "face.smiling.fill")
        let imageOffsetY: CGFloat = 0.0
        attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: " ")
        myString.append(attachmentString)
        let myStringAfter = NSMutableAttributedString(string: "SMILE TO UNLOCK")
        myString.append(myStringAfter)
        label4.attributedText = myString
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.textColor = .white
        //label4.text = ":) SMILE TO PLAY"
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

    /*
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .purple
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.cornerRadius = button.frame.size.width/2
        button.addTarget(self, action: #selector(onSettingsButtonPush), for: .touchUpInside)
        button.clipsToBounds = true
        return button
     */
  //  }()
    
    
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
    
    
    func assignbackground(){
        let background = UIImage(named: "background")

        var imageView : UIImageView!
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = self.center
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameGameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameSongTitle.translatesAutoresizingMaskIntoConstraints = false
        bestScoreTitle.translatesAutoresizingMaskIntoConstraints = false
        mageImage.translatesAutoresizingMaskIntoConstraints = false
        buttonSongLibrary.translatesAutoresizingMaskIntoConstraints = false
        
        nameGameTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: 0).isActive = true
        nameGameTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 60 ).isActive = true
        nameGameTitle.bottomAnchor.constraint(equalTo: nameSongTitle.topAnchor, constant: 0).isActive = true
        
        nameGameTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        nameSongTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: 0).isActive = true
        nameSongTitle.bottomAnchor.constraint(equalTo: bestScoreTitle.topAnchor, constant: 0).isActive = true
        nameSongTitle.topAnchor.constraint(equalTo: nameGameTitle.bottomAnchor).isActive = true
        nameSongTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        bestScoreTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: 0).isActive = true
        bestScoreTitle.bottomAnchor.constraint(equalTo: mageImage.topAnchor, constant: -20).isActive = true
        bestScoreTitle.topAnchor.constraint(equalTo: nameSongTitle.bottomAnchor).isActive = true
        bestScoreTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        mageImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95, constant: 0).isActive = true
        mageImage.topAnchor.constraint(equalTo: bestScoreTitle.bottomAnchor, constant: 0).isActive = true
        mageImage.bottomAnchor.constraint(equalTo: smileToPlayTitle.topAnchor, constant: -20).isActive = true
        mageImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        smileToPlayTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95, constant: 0).isActive = true
        smileToPlayTitle.topAnchor.constraint(equalTo: mageImage.bottomAnchor, constant: 0).isActive = true
        smileToPlayTitle.bottomAnchor.constraint(equalTo: buttonSongLibrary.topAnchor, constant: -20).isActive = true
        smileToPlayTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        buttonSongLibrary.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95, constant: 0).isActive = true
        buttonSongLibrary.topAnchor.constraint(equalTo: smileToPlayTitle.bottomAnchor, constant: 0).isActive = true
        buttonSongLibrary.heightAnchor.constraint(equalToConstant: 61).isActive = true
        buttonSongLibrary.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42).isActive = true
        buttonSongLibrary.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
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
    
    
    @objc func onSongLibraryButtonPush(){
        delegate?.onSongLibraryButtonPush()

            
    }
    
    
    

    
}
