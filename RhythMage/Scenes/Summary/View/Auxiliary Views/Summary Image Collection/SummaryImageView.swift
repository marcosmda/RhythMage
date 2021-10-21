//
//  SummaryImageView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 20/10/21.
//

import UIKit

class SummaryImageView: UIView {
    
    private var summarySetup: SummaryImageSetup?
    private var image: UIImage?
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    init(frame: CGRect, summarySetup: SummaryImageSetup, with image: UIImage){
        super.init(frame: frame)
        self.summarySetup = summarySetup
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        addSubview(imageView)
    }
    
    func setupLayout() {
        imageView.image = UIImage(named: "UserPhoto-Test")!
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    
}
