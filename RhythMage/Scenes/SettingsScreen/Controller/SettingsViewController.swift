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
    func switchValueDidChange()
}

class SettingsViewController: BaseViewController<SettingsView>{
    
    var ableToPlay = false
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var characters = ["TERMS OF USE", "CREDITS"]
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        //mainView.layoutSubviews()
        mainView.backgroundColor = .secondaryBackground
        safeArea = mainView.layoutMarginsGuide
        
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
    

    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: mainView.rectangle.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    
}

extension SettingsViewController: SettingsDelegate {
    func switchValueDidChange() {
    }
    
    
    func onBackButtonPush() {
        navigationController?.pushViewController(factory.createSmileToUnlockScene(), animated: true)
    }

}
/*
extension SettingsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return characters.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      //cell.contentView = SettingsTableViewCell()
      cell.textLabel?.text = characters[indexPath.row]
      cell.textLabel?.tintColor = .white
    return cell
  }
}
*/
