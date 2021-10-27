//
//  TermsOfUseController.swift
//  RhythMage
//
//  Created by Bruna Costa on 26/10/21.
//

import Foundation
import UIKit

class TermsOfUseViewController: BaseViewController<TermsOfUseView>{
    
    var model = TermsOfUseCellModel()
    var index = 0

    typealias Factory = SelectedTermsOfUseSceneFactory
    let factory: Factory
    
    override func viewDidLoad() {
      super.viewDidLoad()
        //mainView.delegate = self
        self.navigationItem.leftBarButtonItem = self.mainView.backButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ///Set the navigationBar Title
        self.navigationItem.titleView = mainView.titleNavBar
        
        }
    
    init (factory: Factory)
    {
        self.factory = factory
        super.init(mainView: TermsOfUseView(frame: .zero))
        //mainView.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension UITableViewDelegate
extension TermsOfUseViewController: UITableViewDelegate, TermsOfUseDelegate{

    

    
    
    ///Set the division inside the tableView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        //headerView.heightAnchor.constraint(equalToConstant: 40)
        //headerView.backgroundColor = self.view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    ///Set the content of the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TermsOfUseCell.reusableIdentifier, for: indexPath) as? TermsOfUseCell else {
            return UITableViewCell()
        }

        cell.sinopse.text =  model.data[indexPath.section].termsSinopse
            //.termsSinopse[indexPath.section]
        cell.title.text =  model.data[indexPath.section].termsTitle.uppercased()
        cell.icon.image = UIImage(systemName: model.data[indexPath.section].termsImage)
        cell.button.setTitle(model.data[indexPath.section].termsButtonText, for: .normal)
        cell.button.setImage(UIImage(systemName: model.data[indexPath.section].termsButtonImage), for: .normal)
        cell.delegate = self
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    ///Set the numbers of cells we will display
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    ///Set navigation afer clicking inside the cell
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        switch indexPath.section {
            
            case 0:
                index = 0
                print("Enter privacy policy")
                
                //self.navigationController?.pushViewController(factory.createCreditsScene(), animated: true)
            case 1:
                index = 1
                print("Enter Interpretation &\nDefinitions")
                
            case 2:
                index = 2
                print("Enter Collecting & Using\nYour Personal Data")
            
            case 3:
                index = 3
                print("Enter Disclosure of Your\nPersonal Data")
                
            case 4:
                index = 4
                print("Enter Access of the Services")
                
            case 5:
                index = 5
                print("Enter Contact Us")
                
            default:
                return nil
            }
        
    return indexPath
    }
    
    func onTermsButtonPush() {
        let vc = SelectedTermsOfUseViewController()
            //vc.username = "Ford Prefect"
            vc.mainView.icon.image = UIImage(systemName: model.data[index].termsImage)
            vc.mainView.title.text =  model.data[index].termsTitle.uppercased()
            vc.mainView.lastUpdated.text = model.data[index].termsUpdated
            vc.mainView.terms.text = model.data[index].termsText
           
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onBackButtonPush(){
        self.navigationController?.popViewController(animated: true)
    }
    
     

}

//MARK: - Extension UITableViewDataSource
extension TermsOfUseViewController: UITableViewDataSource{

    ///Set the layout of tableview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.accessoryType = UITableViewCell.AccessoryType.none

        let selectedView: UIView = UIView(frame: cell.frame)
        //selectedView.layer.cornerRadius = 10
        selectedView.layer.masksToBounds = true
        selectedView.backgroundColor = .clear
        cell.selectedBackgroundView = selectedView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected a row")
    }


}

