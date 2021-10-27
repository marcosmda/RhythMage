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
    var ableToPlay = false
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
        
        ableToPlay = true
        
        ///Set the navigationBar Layout
        let bool = true
        if bool {
            self.navigationItem.title = "Settings"
            let attributes = [NSAttributedString.Key.font: UIFont(name: "Inika-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
        }
        
        
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
        return 1
    }
    
    ///Set the content of the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonCell.reusableIdentifier, for: indexPath) as? SettingsButtonCell else {
            return UITableViewCell()
        }
        cell.setupCell(currentSetting: buttons[indexPath.section])
        return cell
    }
    
    ///Set the height of each tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.00
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    ///Set the numbers of cells we will display
    func numberOfSections(in tableView: UITableView) -> Int {
        return buttons.count
    }
    
    ///Set navigation afer clicking inside the cell
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch indexPath.section {
            case 0:
                print("Enter Terms Of Use")

            case 1:
            print("Enter Credits")
            self.navigationController?.pushViewController(factory.createCreditsScene(), animated: true)
            
            
            case 2:
            print("Enter Allow Camera")
            //Adding the Alert
            /*
                let alertController = UIAlertController (title: "Change Camera Access", message: "For playing with your face and registering your best moments, go to Settings and allow Camera Access.", preferredStyle: .alert)

            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                    }

                    if UIApplication.shared.canOpenURL(URL(string: UIApplication) {
                    UIApplication.shared.open(URL(string: UIApplication, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }*/
            //UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            if let url = URL(string: UIApplication.openSettingsURLString) {
                           if UIApplication.shared.canOpenURL(url) {
                               UIApplication.shared.open(url, options: [:], completionHandler: nil)
                           }
                       }
            //}
                                              /*
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
            */
                
                
                
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

    ///Set the layout of tableview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.accessoryType = UITableViewCell.AccessoryType.none
        var frame = tableView.frame
        frame.size.height = tableView.contentSize.height
        tableView.frame = frame

        let selectedView: UIView = UIView(frame: cell.frame)
        selectedView.layer.cornerRadius = 20
        selectedView.layer.masksToBounds = true
        //.backgroundColor = .terciary
        cell.selectedBackgroundView = selectedView
        //selectedView.backgroundColor = .clear
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected a row")
    }


}


