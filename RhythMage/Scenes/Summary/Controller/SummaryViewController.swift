//
//  SummaryViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class SummaryViewController: BaseViewController<SummaryView> {
    
    var headerView: SummaryHeaderView?
    
    //MARK: - Initializers
    init(){
        let view = SummaryView()
        super.init(mainView: view)
        headerView = SummaryHeaderView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        //mainView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem =  self.mainView.rankingButton
        self.navigationItem.rightBarButtonItem = self.mainView.shareButton
        
    }
    
    override func viewDidLayoutSubviews() {
        self.navigationItem.titleView = headerView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
