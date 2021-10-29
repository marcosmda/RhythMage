//
//  GameCameraDisplayView.swift
//  RhythMage
//
//  Created by Bruna Costa on 29/10/21.
//

import Foundation
import UIKit

class GameCameraDisplayView: UIView{
    
    var delegate: GameSceneDelegate?
    
    ///user camera view
    var previewCameraLayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 5
        view.clipsToBounds = true
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
    //MARK: - Initializers
    init(faceTrackingView: FaceTrackingController) {
        
        super.init(frame: .zero)
        self.previewCameraLayer.addSubview(faceTrackingView)
        setupHiararchy()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Layout Subviews
    func setupLayout(){
        
      NSLayoutConstraint.activate([
          ///Constraints - container
          previewCameraLayer.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: -10),
          previewCameraLayer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
          previewCameraLayer.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
          previewCameraLayer.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    
      ])
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let window = self.window?.windowScene?.keyWindow
        let topPadding = window?.safeAreaInsets.top
    
        previewCameraLayer.topAnchor.constraint(equalTo: self.topAnchor, constant: topPadding!).isActive = true

        delegate?.updateCamera(cameraView: previewCameraLayer) //TODO: estranho
        

    }
    
  
    //MARK: - Hierarchy
    func setupHiararchy(){
        self.addSubview(previewCameraLayer)
    }
    
}
