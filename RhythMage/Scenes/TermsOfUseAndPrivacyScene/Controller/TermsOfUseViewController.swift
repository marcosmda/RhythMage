//
//  TermsOfUseController.swift
//  RhythMage
//
//  Created by Bruna Costa on 26/10/21.
//

import Foundation
import UIKit
import MessageUI

class TermsOfUseViewController: BaseViewController<TermsOfUseView>, MFMailComposeViewControllerDelegate{
    
    var model = TermsOfUseCellModel()
    //var index = 0

    typealias Factory = SelectedTermsOfUseSceneFactory
    let factory: Factory
    
    override func viewDidLoad() {
      super.viewDidLoad()
        //mainView.delegate = self
        self.navigationItem.leftBarButtonItem = self.mainView.backButton
        
        if !MFMailComposeViewController.canSendMail() {
                print("Mail services are not available")
                return
            }
        
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
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["rhythmages.contato@gmail.com"])
            mail.setSubject((NSLocalizedString("Report Issue:", comment: "")))
            mail.setMessageBody("<html><strong><p>This is your message:</p></strong>Bug report, question, feedback, feature request or other\n\n<strong><p>Subject:</p></strong>\n\n\n<strong><p>Full description:</p></strong>\n\nObservation:  You can include files (documents, screen recordings, screenshots, crash logs, etc.) by uploading them to any third-party file-sharing service, such as Dropbox, Google Drive, Microsoft OneDrive or similar, and pasting the URLs above. Please make sure the correct sharing permissions have been set. All files sent to us are 100% confidential.</html>"
                                , isHTML: true)
            
            
            present(mail, animated: true)
        } else {
            // show failure alert
            print("error sending e-mail")
            let alert = UIAlertController(title: "Your request could not be completed", message: "Make sure you have an e-mail account set up on your iPhone", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }


    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
        cell.button.addTarget(self, action: #selector(onTermsButtonPush(sender:)), for: .touchUpInside)
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
                //index = 0
                print("Enter privacy policy")
                
                //self.navigationController?.pushViewController(factory.createCreditsScene(), animated: true)
            case 1:
                //index = 1
                print("Enter Interpretation &\nDefinitions")
                
            case 2:
                //index = 2
                print("Enter Collecting & Using\nYour Personal Data")
            
            case 3:
                //index = 3
                print("Enter Disclosure of Your\nPersonal Data")
                
            case 4:
                //index = 4
                print("Enter Access of the Services")
                
            case 5:
                //index = 5
                print("Enter Contact Us")
                
            default:
                return nil
            }
        
    return indexPath
    }
    
    @objc func onTermsButtonPush(sender: UIButton) {
        let vc = SelectedTermsOfUseViewController()
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? UITableViewCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = mainView.tableView.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        if indexPath[0] == 5{
            
            sendEmail()
        
        }
        else{
            //vc.username = "Ford Prefect"
        vc.mainView.icon.image = UIImage(systemName: model.data[indexPath[0]].termsImage)
        vc.mainView.title.text =  model.data[indexPath[0]].termsTitle.uppercased()
        vc.mainView.lastUpdated.text = model.data[indexPath[0]].termsUpdated
        vc.mainView.terms.text = model.data[indexPath[0]].termsText
           
        
        self.navigationController?.pushViewController(vc, animated: true)
        }
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

