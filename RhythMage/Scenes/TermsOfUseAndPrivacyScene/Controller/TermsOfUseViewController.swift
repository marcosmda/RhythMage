//
//  TermsOfUseController.swift
//  RhythMage
//
//  Created by Bruna Costa on 26/10/21.
//

import Foundation
import UIKit

class TermsOfUseViewController: BaseViewController<TermsOfUseView>{
    
    var buttons = ["TERMS OF USE", "CREDITS"]
    var model = TermsOfUseCellModel()
    
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
    
    init ()
    {
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
extension TermsOfUseViewController: UITableViewDelegate{
    
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
        cell.sinopse.text =  model.termsSinopse[indexPath.section]
        cell.title.text =  model.termsTitle[indexPath.section].uppercased()
        cell.icon.image = UIImage(systemName: model.termsImage[indexPath.section])
        cell.button.setTitle(model.termsButtonText[indexPath.section], for: .normal)
        cell.button.setImage(UIImage(systemName: model.termsButtonImage[indexPath.section]), for: .normal)
        
        return cell
    }
    
   /* ///Set the height of eaach tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
       
    }*/
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    ///Set the numbers of cells we will display
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    ///Set navigation afer clicking inside the cell
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            //let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonCell.reusableIdentifier, for: indexPath)
            switch indexPath.row {
            case 0:
                print("Enter Credits")
                //self.navigationController?.pushViewController(factory.createCreditsScene(), animated: true)

            case 1:
                print("Enter Terms Of Use")
                
            default:
                return nil
            }
        }
    return indexPath
    }
    
}


//MARK: - Extension UITableViewDataSource
extension TermsOfUseViewController: UITableViewDataSource{

    ///Set the layout of tableview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.accessoryType = UITableViewCell.AccessoryType.none

        //let selectedView: UIView = UIView(frame: cell.frame)
        //selectedView.layer.cornerRadius = 10
        //selectedView.layer.masksToBounds = true
        //selectedView.backgroundColor = .terciary
        //cell.selectedBackgroundView = selectedView
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected a row")
    }*/


}
