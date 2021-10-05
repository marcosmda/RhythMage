//
//  SongLibraryViewController.swift
//  RhythMage
//
//  Created by Juliana Prado on 05/10/21.
//

import UIKit

class SongLibraryViewController: BaseViewController<SongLibraryView>{
    
    
    override init(mainView: SongLibraryView) {
        super.init(mainView: SongLibraryView())
        
        mainView.tableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SongLibraryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension SongLibraryViewController: UITableViewDataSource{
    
}
