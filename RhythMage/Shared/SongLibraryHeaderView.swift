//
//  SongLibraryHeaderView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 19/10/21.
//

import UIKit

class SongLibraryHeaderView: UIView {

    private var headerTitle: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //MARK: - Custom Init for Header Title
    init(frame: CGRect, headerTitle: String) {
        super.init(frame: frame)
        self.headerTitle = headerTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        setupViews()
    }
    
    func setupViews() {
        
        let labelView = UIView()
        labelView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        labelView.frame = CGRect.init(x: self.frame.width/4 + self.frame.width/8, y: 10, width: self.frame.width/4, height: 30)
        labelView.layer.cornerRadius = labelView.frame.height/2
        
        let label = UILabel()
        label.text = headerTitle
        label.frame = CGRect.init(x: 10, y: 0, width: labelView.frame.width - 20, height: labelView.frame.height)
        label.font = .inikaBold(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .secondary
        
        labelView.addSubview(label)
        self.addSubview(labelView)
        
    }
  
}
