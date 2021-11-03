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
        
      
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            ///Constraints - container
            previewCameraLayer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            previewCameraLayer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            previewCameraLayer.widthAnchor.constraint(equalTo: self.widthAnchor),
            previewCameraLayer.heightAnchor.constraint(equalTo: self.heightAnchor)
      
        ])
        
        delegate?.updateCamera(cameraView: previewCameraLayer) //TODO: estranho
        
    }
    
  
    //MARK: - Hierarchy
    func setupHiararchy(){
        self.addSubview(previewCameraLayer)
    }
    
}
