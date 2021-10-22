//
//  SettingsViewController.swift
//  RhythMage
//
//  Created by Bruna Costa on 19/10/21.
//

import Foundation
import UIKit

class SettingsViewController: BaseViewController<SettingsView>, UIGestureRecognizerDelegate{
    
    var ableToPlay = false
    var safeArea: UILayoutGuide!
    var buttons = ["TERMS OF USE", "CREDITS"]
    //var user: UserSettings
    
    typealias Factory = SmileToUnlockFactory & CreditsSceneFactory
    let factory: Factory
    
    //var sender: UISwitch
    
    //MARK: - Initializers
    init(factory: Factory){//}, user: UserSettings){
        //self.user = userSettings
        //self.user = user
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
    
    ///Set the height of eaach tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.00
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    ///Set the numbers of cells we will display
    func numberOfSections(in tableView: UITableView) -> Int {
        return buttons.count
    }
    
    ///Set navigation afer clicking inside the cell
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            //let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonCell.reusableIdentifier, for: indexPath)
            switch indexPath.row {
            case 0:
                print("Enter Credits")
                self.navigationController?.pushViewController(factory.createCreditsScene(), animated: true)

            case 1:
                print("Enter Terms Of Use")
                
            default:
                return nil
            }
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


