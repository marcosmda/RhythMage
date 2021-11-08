//
//  SharableView.swift
//  RhythMage
//
//  Created by Lucas Frazão on 08/11/21.
//

import UIKit

class SharableView: UIView {
    
    private var gradientView = GradientBackgroundView()
    
    //Setting the image of the game
    let nameGameTitle: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return imageView
    }()
    
    private var score: Int?
    lazy var pointsView = PointsView(points: self.score ?? 0, message: "OH, SO MAGIC!")
    var summaryImageViewCollection = SummaryImageViewCollection()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, score: Int, images: [UIImage]) {
        self.init(frame: frame)
        self.score = score
        summaryImageViewCollection = SummaryImageViewCollection(frame: frame, with: images)
        configureSummaryImage()
    }
    
    func setupHierarchy() {
        addSubview(gradientView)
        addSubview(nameGameTitle)
        addSubview(pointsView)
    }
    
    func configureSummaryImage() {
        self.addSubview(summaryImageViewCollection)
        summaryImageViewCollection.translatesAutoresizingMaskIntoConstraints = false
        summaryImageViewCollection.topAnchor.constraint(equalTo: self.nameGameTitle.bottomAnchor).isActive = true
        summaryImageViewCollection.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        summaryImageViewCollection.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        pointsView.topAnchor.constraint(equalTo: summaryImageViewCollection.bottomAnchor, constant: 35).isActive = true
    }
    
    func setupLayout() {
        
        nameGameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameGameTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        nameGameTitle.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        nameGameTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        //MARK: - Points View
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pointsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
        
    }

}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        
        let image = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}
