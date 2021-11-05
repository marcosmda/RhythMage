//
//  SmileToResumeView.swift
//  RhythMage
//
//  Created by Juliana Prado on 20/10/21.
//

import UIKit

protocol SmileToResumeViewDelegate {
    func onMainMenuButtonClicked()
}

class SmileToResumeView: UIView{
    
    //MARK: - Properties
    var delegate: SmileToResumeViewDelegate?
    var gradientView = GradientBackgroundView()
    
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
        var songText = "Main Menu"
        button3.backgroundColor = UIColor.terciaryBackground
        button3.tintColor = .label
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.white, for: .normal)
        //TODO: Confirm the colors
        button3.titleLabel!.font = .inikaBold(ofSize: 18)
        button3.layer.cornerRadius = 20
        button3.addTarget(self, action: #selector(onMainMenuButtonClicked), for: .touchUpInside)
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
    
    fileprivate let container: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        return view
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            self.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            self.backgroundColor = .black
        }

        self.frame = UIScreen.main.bounds
        
        container.addSubview(gradientView)
        setupBackGround()
        container.addSubview(pausedTitle)
        progressView.addSubview(smileToResumeTitle)
        //container.addSubview(progressView)
        //container.addSubview(buttonMainMenu)
        self.addSubview(container)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func handleAutoResizingMasks() {
        pausedTitle.translatesAutoresizingMaskIntoConstraints = false
        buttonMainMenu.translatesAutoresizingMaskIntoConstraints = false
        //gradientView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc fileprivate func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: 0)
        self.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    @objc func onMainMenuButtonClicked(){
        delegate?.onMainMenuButtonClicked()
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        
        handleAutoResizingMasks()
       
       // gradientView.setupGradient(with: self.container)
        gradientView.setupCircleBackgroundBlur()
    }
    
    func setupLayout(){
        
        let finalStackView = UIStackView(arrangedSubviews: [pausedTitle,progressView, buttonMainMenu])
        finalStackView.translatesAutoresizingMaskIntoConstraints = false
        finalStackView.axis = .vertical
        finalStackView.spacing = 20
        
        container.addSubview(finalStackView)
        
        ///Constraints - container
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.27).isActive = true
        container.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        
        ///Constraints - smile to resume label
        smileToResumeTitle.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        smileToResumeTitle.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        
        progressView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true

        finalStackView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        finalStackView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        finalStackView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.85).isActive = true
     
        
        //gradientView.widthAnchor.constraint(equalTo: self.container.widthAnchor).isActive = true
        //gradientView.heightAnchor.constraint(equalTo: self.container.heightAnchor).isActive = true
        
        ///animates the container
        animateIn()
    }
    
    func setupBackGround(){
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        gradientView.topAnchor.constraint(equalTo: self.container.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.container.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.container.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.container.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
    }
    
}
