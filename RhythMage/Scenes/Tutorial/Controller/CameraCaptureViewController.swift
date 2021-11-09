//
//  CameraCaptureViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 27/10/21.
//

import UIKit
import AVFoundation

protocol CameraCaptureDelegate {
    func checkIfSoundAvailable(_ button: UIButton)
}


class CameraCaptureViewController: BaseViewController<CameraCapture> {

    private var captureSession: AVCaptureSession!
    private var stillImageOutput: AVCapturePhotoOutput!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var player: AVAudioPlayer?
    
    typealias Factory = SmileToUnlockFactory
    let factory: Factory
    
    var soundSetting = AppContainer().authenticatinController.user.settings.isTutorialSoundOn
    
    init(factory: Factory) {
        self.factory = factory
        let view = CameraCapture()
        super.init(mainView: view)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        prepareStoryAudio()
        setupAudioSettings(mainView.soundOption)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.isHidden = true
        }
        
        setupCameraCaptureSession()
    
    }
    
    private func prepareStoryAudio() {
        guard let path = Bundle.main.path(forResource: "cameraCaptureAudio", ofType:"m4a") else {
            debugPrint("cameraCaptureAudio.m4a not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        } catch {
            print(error.localizedDescription)
        }
        
        player?.delegate = self
    }
    
    private func setupCameraCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd1920x1080
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return  }
        
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize front camera:  \(error.localizedDescription)")
        }
    }
    
    private func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        self.mainView.previewCameraLayer.layer.insertSublayer(videoPreviewLayer, at: 0)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
            DispatchQueue.main.async {
                self?.videoPreviewLayer.frame = (self?.mainView.previewCameraLayer.bounds)!
            }
        }
        
    }
    
    private func setupAudioSettings(_ button: UIButton) {
        
        changeSoundSetting(soundSetting, button)
        
    }
    
}

extension CameraCaptureViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            UserDefaults.standard.set(true, forKey: "Skip")
            self.navigationController?.pushViewController(factory.createSmileToUnlockScene(), animated: true)
    }
    
}

extension CameraCaptureViewController: CameraCaptureDelegate {
    
    func checkIfSoundAvailable(_ button: UIButton) {
        
        soundSetting.toggle()
        
        AppContainer().authenticatinController.updateUserSettings(for: UserSettingsKeys.isTutorialSoundOn.rawValue, to: soundSetting)
        
        changeSoundSetting(soundSetting, button)
        
    }
    
    
    private func changeSoundSetting(_ soundSetting: Bool, _ button: UIButton) {
     
        switch soundSetting {
            case true:
                player?.volume = 1.0
                UIView.transition(with: button, duration: 0.3, options: .transitionCrossDissolve) {
                    button.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
                }

            case false:
                player?.volume = 0.0
                UIView.transition(with: button, duration: 0.3, options: .transitionCrossDissolve) {
                    button.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
            }
        }
        
    }
    
}
