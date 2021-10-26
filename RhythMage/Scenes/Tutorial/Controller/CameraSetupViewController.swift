//
//  CameraSetupViewController.swift
//  RhythMage
//
//  Created by Lucas Frazão on 26/10/21.
//

import UIKit

class CameraSetupViewController: BaseViewController<CameraAccessView> {

    init() {
        let view = CameraAccessView()
        super.init(mainView: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
