//
//  CollectionViewsCustom.swift
//  Givy
//
//  Created by Max on 18.07.2024.
//

import UIKit

struct CellModel {
    let imageName: String
    let attributedTitle: NSAttributedString
    let subtitle: String
}

class OnboardingCollectionViewsCustomCell: UICollectionViewCell {
    
    //MARK: - Private properties
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 26)
        return title
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.textColor = .gray
        subtitle.numberOfLines = 0
        subtitle.font = UIFont.boldSystemFont(ofSize: 15)
        return subtitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        
        createLabelConstrains()
        createSubtitleConstrains()
        createImageConstrains()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: CellModel) {
        image.image = UIImage(named: model.imageName)
        titleLabel.attributedText = model.attributedTitle
        subtitleLabel.text = model.subtitle
    }
}

//MARK: - Create Collection Views CustomCell Constrains
private extension OnboardingCollectionViewsCustomCell {
    
    //MARK: - Constrains Image
    func createImageConstrains() {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.bottomAnchor.constraint(equalTo: titleLabel.topAnchor)
        ])
    }
    
    //MARK: - Constrains Title
    func createLabelConstrains() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -10),
        ])
    }
    
    //MARK: - Constrains Subtitle
    func createSubtitleConstrains() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
        ])
    }
}
