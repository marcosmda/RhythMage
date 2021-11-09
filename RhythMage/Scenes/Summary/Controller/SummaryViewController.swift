//
//  SummaryViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit
import GameKit
import ARKit
import LinkPresentation

protocol SummaryDelegate {
    func goToMainMenu()
    func goToSongLibrary()
    func goToLeaderboards()
    func goToShareSheet()
}

class SummaryViewController: BaseViewController<SummaryView> {
    
    var headerView: SummaryHeaderView?
    let songMock = SongMock()
    
    let faceTrackingController: FaceTrackingController
    let authenticationController: AuthenticationController
    
    typealias Factory = SummaryFactory & SongLibrarySceneFactory & GameSceneFactory
    let factory: Factory
    
    private let score: Int
    private let level: Level
    private let images: [UIImage]
    private var urlOfImageToShare: URL?
    
    // Inidcates if the view controller prepared to change the scene for preventing multiple navigations
    private var changedScene = false
    
    
    //MARK: - Initializers
    init(factory:Factory, authenticationController: AuthenticationController, faceTrackingController: FaceTrackingController, score: Int, level: Level, images: [UIImage]){
        self.factory = factory
        self.authenticationController = authenticationController
        self.faceTrackingController = faceTrackingController
        self.score = score
        self.level = level
        self.images = images
        let view = SummaryView(with: images, points: score, message: "Magic in the air!")
        super.init(mainView: view)
        headerView = SummaryHeaderView(frame: .zero, songText: level.songName, artistText: "")
        
        mainView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem =  self.mainView.rankingButton
        self.navigationItem.rightBarButtonItem = self.mainView.shareButton
        self.navigationItem.titleView = headerView
        //mainView.titleNavBar.text = "Your Performace for" + (level.songName + level.artistName).uppercased()
        //self.navigationItem.titleView = mainView.titleNavBar
        self.navigationItem.titleView?.contentMode = .scaleAspectFit
        self.navigationItem.titleView?.clipsToBounds = true
        setupGameKit()
        submitScoreToLB()
        saveScore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        self.headerView?.layer.masksToBounds = false
        setupFaceTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        faceTrackingController.kill()
    }
    
    
    private func submitScoreToLB() {
        // Submitting to a specific occurrence of a recurring leaderboard
        GKLeaderboard.loadLeaderboards(IDs:["rhythmage.bestscores"]) { (fetchedLBs, error) in
            if let lb = fetchedLBs?.first {
                lb.submitScore(self.score, context: 0, player: GKLocalPlayer.local) { error in
                }
            }
        }
    }
    
    //MARK: - Methods
    private func saveScore() {
        authenticationController.updateUserHighScore(for: level.getId(), to: String(score))
    }
}

//MARK: - SummaryDelegate
extension SummaryViewController: SummaryDelegate {
    
    func goToMainMenu() {
        self.navigationController?.popToViewController(ofClass: SmileToUnlockController.self, animated: true)
    }
    
    func goToSongLibrary() {
        self.navigationController?.pushViewController(factory.createSongLibraryScene(), animated: true)
    }
    
    func goToLeaderboards() {
        
        let viewController = GKGameCenterViewController(leaderboardID: "rhythmage.bestscores",
                                                        playerScope: .global,
                                                        timeScope: .allTime)
        viewController.gameCenterDelegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    func goToShareSheet() {
        self.showShareActivity(msg: "I've made \(self.score) points playing RhythMage. Download it now: https://testflight.apple.com/join/L9igbwiB")
    }
    
    
}

//MARK: - GKGameCenterControllerDelegate
extension SummaryViewController: GKGameCenterControllerDelegate {
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated:true)
    }
    
    func setupGameKit() {
        
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            
            if let viewController = viewController {
                // Present the view controller so the player can sign in.
                
                self.present(viewController, animated: true, completion: nil)
                
                return
            }
            
            if error != nil {
                // Player could not be authenticated.
                // Disable Game Center in the game.
                GKAccessPoint.shared.isActive = false
                return
            }
            
            // Player was successfully authenticated.
            // Check if there are any player restrictions before starting the game.
            
            if GKLocalPlayer.local.isUnderage {
                // Hide explicit game content.
            }
            
            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // Disable multiplayer game features.
            }
            
            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                // Disable in game communication UI.
            }
            
            GKAccessPoint.shared.isActive = false
            
        }
        
        
        
    }
    
}

//MARK: - FaceTrackingControllerDelegate
extension SummaryViewController: FaceTrackingControllerDelegate {
    
    fileprivate func setupFaceTracking() {
        mainView.addSubview(faceTrackingController)
        faceTrackingController.initialConfiguration()
        faceTrackingController.isEnabled = true
        faceTrackingController.delegates.append(self)
        faceTrackingController.addTrackedFaces(faces: [.mouthSmileLeft])
    }
    
    func faceRecognized(face: ARFaceAnchor.BlendShapeLocation) {}
    
    func faceHeld(face: ARFaceAnchor.BlendShapeLocation, for time: Double) {
        DispatchQueue.main.async {
            self.mainView.interactionsButtonView.progressView.setProgress(Float(time/2), animated: true)
        }
        if !changedScene && time >= 2 {
            changedScene = true
            DispatchQueue.main.async {
                self.faceTrackingController.kill()
                self.navigationController?.popToViewController(ofClass: GameViewController.self)
            }
        }
    }
    
    func faceReleased() {
        DispatchQueue.main.async {
            self.mainView.interactionsButtonView.progressView.setProgress(0, animated: true)
        }
    }
    
}


//MARK: - Sharable Image Function
extension SummaryViewController {
    
    func showShareActivity(msg: String?) {
        
        let shareableView = SharableView(frame: UIScreen.main.bounds, score: score, images: images)
        
        let image = shareableView.asImage()
        
        let activityViewController = UIActivityViewController(activityItems: [msg!, image], applicationActivities: nil)
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
}

extension SummaryViewController: UIActivityItemSource {

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage() // an empty UIImage is sufficient to ensure share sheet shows right actions
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
    
        return urlOfImageToShare
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()

        metadata.title = "I've made \(score) on RhythMage." // Preview Title
        metadata.originalURL = urlOfImageToShare // determines the Preview Subtitle
        metadata.url = urlOfImageToShare
        metadata.imageProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)
        metadata.iconProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)

        return metadata
    }
}
