//
//  CameraTableViewCell.swift
//  RhythMage
//
//  Created by Bruna Costa on 28/10/21.
//

import UIKit

class CameraTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "CameraTableViewCell"
    
    lazy var cameraImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "CameraAccessSmall")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    ///Create the title that explain the use of the camera
    var explanationCameraText: UILabel = {
        let label3 = UILabel(frame: .zero)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "For playing with your face and registering your best moments, go to Settings and allow Camera Access."
        label3.textColor = .secondary
        label3.numberOfLines = 0
        label3.textAlignment = .center
        label3.font = UIFont(name: "SF Pro Text", size: 14)
        label3.setContentHuggingPriority(.defaultHigh, for: .vertical)
      
        return label3
        
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CameraTableViewCell.reusableIdentifier)
        self.addSubview(cameraImage)
        self.addSubview(explanationCameraText)
        self.backgroundColor = .clear
        
        setImageAndTextForCamera()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageAndTextForCamera(){
        
        NSLayoutConstraint.activate([
            cameraImage.topAnchor.constraint(equalTo: self.topAnchor),
            cameraImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cameraImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //cameraImage.bottomAnchor.constraint(equalTo: explanationCameraText.topAnchor),

            explanationCameraText.topAnchor.constraint(equalTo: cameraImage.bottomAnchor),
            explanationCameraText.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            explanationCameraText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            explanationCameraText.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    func setupCell() {
        setImageAndTextForCamera()
    }
    

}
