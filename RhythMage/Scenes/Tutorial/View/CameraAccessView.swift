//
//  CameraAccessView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 26/10/21.
//

import UIKit
import Photos

protocol CameraAccessDelegate {
    func didAuthorizeCameraAccess()
}

class CameraAccessView: UIView {
    
    let gradientView = GradientBackgroundView()
    
    var delegate: CameraAccessDelegate?
    
    lazy var topMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RHYTHMAGE REQUIRES CAMERA ACCESS TO PLAY"
        label.font = .inikaBold(ofSize: 25)
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var bottomMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "it's only used to play and show your best moments!\n\nit's all local".uppercased()
        label.font = .inikaBold(ofSize: 25)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    //MARK: - Mage Image
    let cameraAccessImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cameraAccess")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    let buttonSongLibrary: UIButton = {
        let button3 = UIButton(frame: .zero)
        button3.translatesAutoresizingMaskIntoConstraints = false
        var songText = " Allow Camera Access"
        button3.backgroundColor = .white
        button3.setImage(UIImage(systemName: "camera"), for: .normal)
        button3.tintColor = .label
        button3.setTitle(songText.uppercased(), for: .normal)
        button3.contentVerticalAlignment = .center
        button3.setTitleColor(.label, for: .normal)
        button3.titleLabel!.font = .inikaBold(ofSize: 20)
        button3.layer.cornerRadius = 20
        button3.addTarget(self, action: #selector(checkCameraPermission), for: .touchUpInside)
        return button3
    }()
    
    @objc func checkCameraPermission(_ sender: UIButton) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            print("SYSTEM RESPONSE: This device's camera authorization was already granted.")
            delegate?.didAuthorizeCameraAccess()
            return
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.delegate?.didAuthorizeCameraAccess()
                }
            }
        case .denied: // The user has previously denied access.
            return
        case .restricted: // The user can't grant access due to restrictions.
            return
        @unknown default:
            fatalError("This case should't exist")
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(gradientView)
        addSubview(topMessage)
        addSubview(cameraAccessImage)
        addSubview(buttonSongLibrary)
        addSubview(bottomMessage)
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupLayout() {
        gradientView.setupCircleBackgroundBlur()
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        topMessage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        topMessage.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        topMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        cameraAccessImage.widthAnchor.constraint(equalTo: self.topMessage.widthAnchor).isActive = true
        cameraAccessImage.topAnchor.constraint(equalTo: self.topMessage.bottomAnchor).isActive = true
        cameraAccessImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        buttonSongLibrary.topAnchor.constraint(equalTo: cameraAccessImage.bottomAnchor).isActive = true
        buttonSongLibrary.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        buttonSongLibrary.heightAnchor.constraint(equalToConstant: 51).isActive = true
        buttonSongLibrary.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        bottomMessage.topAnchor.constraint(equalTo: buttonSongLibrary.bottomAnchor, constant: 15).isActive = true
        bottomMessage.bottomAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        bottomMessage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        bottomMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
}
