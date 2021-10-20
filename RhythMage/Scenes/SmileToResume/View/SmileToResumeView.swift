//
//  SmileToResumeView.swift
//  RhythMage
//
//  Created by Juliana Prado on 20/10/21.
//

import UIKit

class SmileToResumeView: UIView{
    
    //MARK: - Properties
    var delegate: SmileToResumeDelegate?
    
    ///Title inside the progressbar to describe what the user has to do
    let smileToResumeTitle: UILabel = {
        let label4 = UILabel(frame: .zero)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "face.smiling.fill")?.withTintColor(.white)
        let imageOffsetY: CGFloat = -2.0
        attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: " ")
        myString.append(attachmentString)
        let myStringAfter = NSMutableAttributedString(string: " SMILE TO RESUME")
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
    ///Progress bar to display how much time the user will need to smile
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .secondaryBackground
        progressView.progressTintColor = .white
        progressView.layer.cornerRadius = 20
        progressView.clipsToBounds = true
        return progressView
    }()
    ///Button that leads to the main menu
    let buttonMainMenu: UIButton = {
        let button3 = UIButton(frame: .zero)
        var songText = " Song Library"
        button3.backgroundColor = .white
        button3.setImage(UIImage(systemName: "music.note"), for: .normal)
        button3.tintColor = .label
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.label, for: .normal)
        //TODO: Confirm the colors
        button3.titleLabel!.font = .inikaBold(ofSize: 20)
        button3.layer.cornerRadius = 20
        button3.addTarget(self, action: #selector(onMainMenuButtonClick), for: .touchUpInside)
        return button3
    }()
    
    ///Title of the view
    lazy var pausedTitle: UILabel = {
        let label3 = UILabel(frame: .zero)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.textColor = .white
        label3.text = "PAUSED"
        label3.numberOfLines = 0
        label3.textAlignment = .center
        label3.font = .inika(ofSize: 18)
        label3.contentMode = .scaleAspectFill
        label3.minimumScaleFactor = 0.1
        label3.sizeToFit()
        label3.fitTextToBounds()
        return label3
        
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(pausedTitle)
        self.addSubview(progressView)
        progressView.addSubview(smileToResumeTitle)
        self.addSubview(buttonMainMenu)
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func handleAutoResizingMasks() {
        pausedTitle.translatesAutoresizingMaskIntoConstraints = false
        buttonMainMenu.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func onMainMenuButtonClick(){
        delegate?.onMainMenuButtonClicked()
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        handleAutoResizingMasks()
        
        
        smileToResumeTitle.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        smileToResumeTitle.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        
        progressView.widthAnchor.constraint(equalTo: buttonMainMenu.widthAnchor).isActive = true
        progressView.topAnchor.constraint(equalTo: pausedTitle.bottomAnchor, constant: 20).isActive = true
        progressView.bottomAnchor.constraint(equalTo: buttonMainMenu.topAnchor, constant: -20).isActive = true
        progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        progressView.heightAnchor.constraint(equalTo: buttonMainMenu.heightAnchor).isActive = true
        
        buttonMainMenu.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        buttonMainMenu.topAnchor.constraint(equalTo: smileToResumeTitle.bottomAnchor, constant: 20).isActive = true
        buttonMainMenu.heightAnchor.constraint(equalToConstant: 51).isActive = true
        buttonMainMenu.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42).isActive = true
        buttonMainMenu.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
}
