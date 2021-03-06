//
//  GameViewController+GameScene.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 29/10/21.
//

import UIKit
import AVFoundation

extension GameViewController: GameSceneDelegate {
    
    func viewWillAppearGameScene() {
        mainScene.resetScore()
    }
    
    func updateCamera(cameraView: UIView) {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { fatalError("no front camera. but don't all iOS 15 devices have them? Check if you are running on the iOS Simulator. You need a physical device ;)") }
        
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)

                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer.videoGravity = .resizeAspectFill
                videoPreviewLayer.connection?.videoOrientation = .portrait
                cameraView.layer.insertSublayer(videoPreviewLayer, at: 0)
                
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    self?.captureSession.startRunning()
                    DispatchQueue.main.async {
                        self?.videoPreviewLayer.frame = cameraView.bounds
                    }
                }
                
            }
        }
        catch let error  {
            print("Error Unable to initialize front camera:  \(error.localizedDescription)")
        }
    }

    func getElapsedTime() {
        var progress = Float()
        progress = Float((audioController.getPlayerTime() ?? 0.0)/(audioController.getAudioDuration() ?? 0.0))
        DispatchQueue.main.async {
            self.gameDisplayView.progressView.setProgress(progress, animated: true)
        }
       
    }
    
    func pauseGame() {
        guard let navController = self.navigationController else {return}
        let vc = factory.createSmileToResumeScene(rootNavController: navController)
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            navController.present(vc, animated: false)
            self.toggleGameStatus()
        }
    }
    
    func updatedScore(score: Double) {
        gameDisplayView.song.setScore(score: Int(score))
    }
    
    func createTiles() {
        guard let interactionSequence = level.sequences.first else{return}
        
        for interaction in interactionSequence.sequence {
            guard let tile = interaction as? TileInteraction else {break}
            mainScene.addTileOrb(tile: tile, scrollVelocity: scrollVelocity, startDelayTime: startDelayTime)
        }
    }
}
