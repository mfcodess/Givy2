//
//  CollectionViews.swift
//  Givy
//
//  Created by Max on 18.07.2024.
//


import UIKit

class MainHeaderCollectionViewCell: UICollectionViewCell {
    
    static let id = "MainCollectionViewCell"
    
    private lazy var imageHeader: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        createImageHeaderConstraints()
        
        imageHeader.layer.cornerRadius = 10
        imageHeader.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(imageHeader)
    }
    
    func configure(image: String) {
        imageHeader.image = UIImage(named: image)
    }
    
    func createImageHeaderConstraints() {
        NSLayoutConstraint.activate([
            imageHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageHeader.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
