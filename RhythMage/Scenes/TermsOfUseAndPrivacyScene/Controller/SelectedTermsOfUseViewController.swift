//
//  SelectedTermsOfUseViewController.swift
//  RhythMage
//
//  Created by Bruna Costa on 26/10/21.
//

import Foundation
import UIKit

class SelectedTermsOfUseViewController: BaseViewController <SelectedTermOfUseView>,UIGestureRecognizerDelegate,SelectedTermsDelegate{

    
    var model = TermsOfUseCellModel()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        mainView.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.leftBarButtonItem = self.mainView.backButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ///Set the navigationBar Title
        self.navigationItem.titleView = mainView.titleNavBar
        
        }
    
    init ()
    {
        
        super.init(mainView: SelectedTermOfUseView(frame: .zero))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onBackButtonPushTerms() {
        
        self.navigationController?.popViewController(animated: true)
        //self.navigationController?.pushViewController(factory.createTermsOfUseScene(), animated: true)
    }
    
    
}
