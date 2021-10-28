//
//  SettingsViewController.swift
//  RhythMage
//
//  Created by Bruna Costa on 19/10/21.
//

import Foundation
import UIKit

class SettingsViewController: BaseViewController<SettingsView>, UIGestureRecognizerDelegate{
    //MARK: Injected Properties
    typealias Factory = SmileToUnlockFactory & CreditsSceneFactory
    let factory: Factory
    let authenticationController: AuthenticationController
    
    //MARK: Properties
    var safeArea: UILayoutGuide!
    var buttons = ["TERMS OF USE AND PRIVACY", "CREDITS", "ALLOW CAMERA ACCESS"]
    var user: User {
        if let user = authenticationController.user {
            return user
        } else {
            return User.empty()
        }
    }
    //var sender: UISwitch
    
    //MARK: - Initializers
    init(factory: Factory, authenticationController: AuthenticationController){
        self.authenticationController = authenticationController
        self.factory = factory
        let view = SettingsView(frame: .zero)//, userSettings: user)//, userSettings: user)
        super.init(mainView: view)
        mainView.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
       // mainView.setupCell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        mainView.backgroundColor = .secondaryBackground
        mainView.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.leftBarButtonItem = self.mainView.backButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

            self.navigationItem.title = "Settings"
            let attributes = [NSAttributedString.Key.font: UIFont(name: "Inika-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        
        
    }

    
}
    
//MARK: - Extension UITableViewDelegate
extension SettingsViewController: UITableViewDelegate{
    ///Set the division inside the tableView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = self.view.backgroundColor
        return headerView
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 1:
            return buttons.count
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    ///Set the content of the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonCell.reusableIdentifier, for: indexPath) as? SettingsButtonCell else {
                return UITableViewCell()
            }
            cell.setupCell(currentSetting: buttons[indexPath.row])
            //cell.selectionStyle = .none
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CameraTableViewCell.reusableIdentifier, for: indexPath) as? CameraTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell()
            cell.selectionStyle = .none
           
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HapticCell.reusableIdentifier, for: indexPath) as? HapticCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.setupCell()
            return cell
        }
    }
    
    ///Set the height of each tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 80
        case 1:
            return 60
            
        case 2:
            return 180
        
        default:
            return 60
        }
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    ///Set the numbers of cells we will display
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    ///Set navigation afer clicking inside the cell
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if mainView.tableView.indexPathForSelectedRow == indexPath{
            mainView.tableView.deselectRow(at: indexPath, animated: true)
        }
        switch indexPath.section {
            case 0:
                print("Haptic Feedback")
            case 1:
            switch indexPath.row{
            case 0:
                print("Terms Of Use")
            case 1:
                print("Credits")
                self.navigationController?.pushViewController(factory.createCreditsScene(), animated: true)
            case 2:
                print("Enter Allow Camera")
            //Adding the Alert
                let alertController = UIAlertController (title: "Change Camera Access", message: "For playing with your face and registering your best moments, go to Settings and allow Camera Access.", preferredStyle: .alert)

                let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }

                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    }
                }
                alertController.addAction(settingsAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)

                present(alertController, animated: true, completion: nil)
            default:
                return nil
            }
            default:
                return nil
            
        }
    return indexPath
    }
    
}

extension SettingsViewController: SettingsDelegate {
    func switchValueDidChange() {
    }
    
    
    func onBackButtonPush() {
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK: - Extension UITableViewDataSource
extension SettingsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        //mainView.tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
            case 0:
           // mainView.tableView.allowsSelection = false
                print("Haptic Feedback")
            case 1:
            
            switch indexPath.row{
            case 0:
                print("Terms Of Use")
            case 1:
                print("Credits")
              
            case 2:
                print("Enter Allow Camera")
                

            default:
                break
            }

            
        default: break
            
        }
   
    }

}


