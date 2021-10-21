//
//  SettingsViewController.swift
//  RhythMage
//
//  Created by Bruna Costa on 19/10/21.
//

import Foundation
import UIKit

protocol SettingsDelegate {
    func onBackButtonPush()
    func onTermsOfUsePush()
    func onCreditsPush()
    func switchValueDidChange()
}

class SettingsViewController: BaseViewController<SettingsView>{
    
    var ableToPlay = false
    var safeArea: UILayoutGuide!
    var buttons = ["TERMS OF USE", "CREDITS"]
    //var user: User
    
    typealias Factory = SmileToUnlockFactory
    let factory: Factory
    
    //var sender: UISwitch
    
    //MARK: - Initializers
    init( factory: Factory){//user: User,
        //self.user = user
        self.factory = factory
        let view = SettingsView(frame: .zero)//, userSettings: user.userSettings)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ableToPlay = true
        
        let bool = true
        if bool {
            self.navigationItem.title = "Settings"
            let attributes = [NSAttributedString.Key.font: UIFont(name: "Inika-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
            self.navigationItem.leftBarButtonItem = self.mainView.backButton
        }
        
        
    }
}
    
//MARK: - Extension UITableViewDelegate
extension SettingsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.backgroundColor = self.view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonCell.reusableIdentifier, for: indexPath) as? SettingsButtonCell else {
            return UITableViewCell()
        }
        cell.setupCell(currentSetting: buttons[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.00
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return buttons.count
    }
}
extension SettingsViewController: SettingsDelegate {
    func onTermsOfUsePush() {
        // navigationController?.pushViewController(factory.createTermsOfUseScene(), animated: true)
    }
    
    func onCreditsPush() {
        //navigationController?.pushViewController(factory.createCreditsScene(), animated: true)
    }
    
    func switchValueDidChange() {
    }
    
    
    func onBackButtonPush() {
       // navigationController?.pushViewController(factory.createSmileToUnlockScene(), animated: true)
    }

}

//MARK: - Extension UITableViewDataSource
extension SettingsViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.accessoryType = UITableViewCell.AccessoryType.none

        let selectedView: UIView = UIView(frame: cell.frame)
        selectedView.layer.cornerRadius = 10
        selectedView.layer.masksToBounds = true
        selectedView.backgroundColor = .terciary
        cell.selectedBackgroundView = selectedView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected a row")
    }


}


