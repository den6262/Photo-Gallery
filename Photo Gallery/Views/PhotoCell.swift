//
//  PhotoCell.swift
//  Photo Gallery
//
//  Created by Deniro21 on 1/15/20.
//  Copyright © 2020 Denys Hryshyn. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class PhotoCell: UICollectionViewCell {
    
    static let reuseId = "PhotoCell"
        
    let history = History()
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            photoImgView.sd_setImage(with: url, completed: nil)
            
            
        }
    }
    
    let photoImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImgView.image = nil
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
        
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImgView)
        photoImgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
