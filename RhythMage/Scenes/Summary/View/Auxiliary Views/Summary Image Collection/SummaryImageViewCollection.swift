//
//  SummaryImageViewCollection.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class SummaryImageViewCollection: UIView {

    var summaryViews: [SummaryImageView] = [SummaryImageView(), SummaryImageView(), SummaryImageView()]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        
        var i = summaryViews.count
        
        while i > 0 {
            i -= 1
            addSubview(summaryViews[i])
        }
        
        for view in summaryViews {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
            view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.67).isActive = true
        }
        
        
    }
    
    func setupLayout() {
        
        var i = 0
        let horizontalSpacing = 10
        let verticalSpacing = 30.0
        let rotation = [0.0, 0.3, -0.3]
        
        summaryViews[0].leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        while i < summaryViews.count {
            summaryViews[i].transform = summaryViews[i].transform.rotated(by: CGFloat(rotation[i]))
            
            i += 1
            
            if i < summaryViews.count {
                summaryViews[i].leadingAnchor.constraint(equalTo: summaryViews[i-1].trailingAnchor, constant: -10).isActive = true
                summaryViews[i].widthAnchor.constraint(equalTo: summaryViews[i-1].widthAnchor).isActive = true
                
                if i % 2 != 0 {
                    summaryViews[i].centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: verticalSpacing).isActive = true
                }
                
                
            } else {
                summaryViews[2].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            }
            
            
        }
        
    }
    

}
