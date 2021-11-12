//
//  CreditsSceneViewController.swift
//  RhythMage
//
//  Created by Bruna Costa on 20/10/21.
//

import Foundation
import UIKit


class CreditsSceneViewController: BaseViewController<CreditsView>, UIGestureRecognizerDelegate, CreditsSceneDelegate, UITableViewDataSource{
    

    typealias Factory = SettingsSceneFactory
    let factory: Factory
     var timer = Timer()
    
    var model = CreditsModel()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        mainView.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.leftBarButtonItem = self.mainView.backButton
        //mainView.tableView.sectionFooterHeight = 30
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollTableView), userInfo: nil, repeats: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.titleView = mainView.titleNavBar
        mainView.tableView.estimatedSectionFooterHeight = 50
}
    
    init (factory:Factory)
    {
        self.factory = factory
        super.init(mainView: CreditsView())
        mainView.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onBackButtonPush() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func scrollTableView(){
      // let indexPath = NSIndexPath(item: 3, section: 2)
       // mainView.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
       /* if timer == nil {
            mainView.tableView.scrollsToTop = true
        }*/

    }
}

//MARK: - Extension UITableViewDelegate
extension CreditsSceneViewController: UITableViewDelegate{
    
        ///Set the division inside the tableView
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = .clear
            return headerView
        }
         

        
        ///Set the content of the tableview
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            switch indexPath.section{
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RhythMageLogo.reusableIdentifier, for: indexPath) as? RhythMageLogo else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
                
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NoCashLogo.reusableIdentifier, for: indexPath) as? NoCashLogo else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
                
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AutorsCredits.reusableIdentifier, for: indexPath) as? AutorsCredits else {
                    return UITableViewCell()
                }
                
                cell.selectionStyle = .none
                cell.setupCell(title: model.data[indexPath.row].title, autor: model.data[indexPath.row].creators)
                return cell
            }
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 8
        }
    }
        ///Set the height of each tableview
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.section{
            case 0:
                return 150
            case 1:
                return 180
            default:
                switch indexPath.row{
                case 0:
                    return 110 //two
                case 1:
                    return 180 //five
                case 2:
                    return 150 //three
                case 3:
                    return 110 //two
                case 4:
                    return 220 //five
                default:
                    return 70 //one
                }
            }
           
        }
    
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int, indexPath: IndexPath) -> CGFloat {
            return 20 //one
        }
   //MARK: Not calling this function
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int, indexPath: IndexPath) -> CGFloat{
        switch section{
        case 0:
            return 0
        case 1:
            return 0
        default:
            return 30
            /*
            switch indexPath.row{
                case 0:
                    return 30 //two
                case 1:
                    return 30 //five
                case 2:
                    return 30 //three
                case 3:
                    return 30 //two
                case 4:
                    return 30 //five
                default:
                    return 30 //one
                }*/
            }
        
    }
        
        ///Set the numbers of cells we will display
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
}

