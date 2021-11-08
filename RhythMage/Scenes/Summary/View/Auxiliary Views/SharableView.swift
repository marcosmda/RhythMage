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
    lazy var pointsView = PointsView(points: self.score ?? 1790, message: "OH, SO MAGIC!")
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
    }
    
    func setupHierarchy() {
        addSubview(gradientView)
        addSubview(nameGameTitle)
        addSubview(summaryImageViewCollection)
        addSubview(pointsView)
    }
    
    func setupLayout() {
        
        nameGameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameGameTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: 0).isActive = true
        nameGameTitle.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        nameGameTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        summaryImageViewCollection.translatesAutoresizingMaskIntoConstraints = false
        summaryImageViewCollection.topAnchor.constraint(equalTo: self.nameGameTitle.bottomAnchor, constant: 50).isActive = true
        summaryImageViewCollection.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        summaryImageViewCollection.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        
        //MARK: - Points View
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pointsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        pointsView.topAnchor.constraint(equalTo: summaryImageViewCollection.bottomAnchor, constant: 35).isActive = true
        pointsView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.setupCircleBackgroundBlur()
        
    }

}

extension UIView {
    func scale(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scale(by: scale)
        }
    }

    func getImage(scale: CGFloat? = nil) -> UIImage {
        let newScale = scale ?? UIScreen.main.scale
        self.scale(by: newScale)

        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale

        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)

        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }

        return image
    }
}
