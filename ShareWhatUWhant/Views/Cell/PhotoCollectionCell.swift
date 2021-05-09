//
//  PhotoCollectionCell.swift
//  ShareWhatUWhant
//
//  Created by Moussa SOW on 25/04/2021.
//

import UIKit
import SDWebImage

class PhotoCollectionCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost) {
        let url = model.thumbnailImage
        // let framework download the image
        photoImageView.sd_setImage(with: url, completed: nil)
        
        
        /* Download image for our own (Gestion de cache à faire)
         * let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
         *    self.photoImageView.image = UIImage(data: data!)
         * }
         */
        
        
        
    }
    
    public func configure(debug imageName: String) {
        photoImageView.image = UIImage(named: imageName)
    }
}
