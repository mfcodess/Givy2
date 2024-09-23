import UIKit

class MainProductCollectionViewCell: UICollectionViewCell {
    
    static let id = "MainProductCollectionViewCell"
    
    private lazy var imageProduct: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .colorGray
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.cornerRadius = 10
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return image
    }()
    
    private lazy var titleNameProduct: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = .boldSystemFont(ofSize: 14)
        title.textColor = .colorButtonIsActive
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var subtitlePriceProduct: UILabel = {
        let subtitle = UILabel()
        subtitle.textAlignment = .left
        subtitle.font = UIFont.systemFont(ofSize: 13)
        subtitle.textColor = .colorButtonIsActive
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    
    private lazy var viewTitleAndSubtitle: UIView = {
        let view = UIView()
        view.backgroundColor = .colorWhiteShop
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleNameProduct)
        view.addSubview(subtitlePriceProduct)
        
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        return view
    }()
    
    private lazy var stackViewTitleAndSubtitle: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.layer.shadowColor = UIColor.gray.cgColor
        stackView.layer.shadowOffset = CGSize(width: 0, height: 1)
        stackView.layer.shadowOpacity = 0.5
        stackView.layer.shadowRadius = 1
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(viewTitleAndSubtitle)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        //imageProduct.layer.cornerRadius = 10
        imageProduct.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(imageProduct)
        contentView.addSubview(stackViewTitleAndSubtitle)
    }
    
    func setupProduct(image: String, title: String, subtitle: String) {
        imageProduct.image = UIImage(named: image)
        titleNameProduct.text = title
        subtitlePriceProduct.text = subtitle
    }
 
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for imageProduct
            imageProduct.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageProduct.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageProduct.bottomAnchor.constraint(equalTo: stackViewTitleAndSubtitle.topAnchor),
            
            // Constraints for stackViewTitleAndSubtitle
            stackViewTitleAndSubtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewTitleAndSubtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackViewTitleAndSubtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Constraints for viewTitleAndSubtitle
            viewTitleAndSubtitle.leadingAnchor.constraint(equalTo: stackViewTitleAndSubtitle.leadingAnchor),
            viewTitleAndSubtitle.trailingAnchor.constraint(equalTo: stackViewTitleAndSubtitle.trailingAnchor),
            viewTitleAndSubtitle.topAnchor.constraint(equalTo: stackViewTitleAndSubtitle.topAnchor),
            viewTitleAndSubtitle.bottomAnchor.constraint(equalTo: stackViewTitleAndSubtitle.bottomAnchor),
            viewTitleAndSubtitle.heightAnchor.constraint(equalToConstant: 55),
            
            // Constraints for titleNameProduct
            titleNameProduct.topAnchor.constraint(equalTo: viewTitleAndSubtitle.topAnchor, constant: 10),
            titleNameProduct.leadingAnchor.constraint(equalTo: viewTitleAndSubtitle.leadingAnchor, constant: 10),
            titleNameProduct.trailingAnchor.constraint(equalTo: viewTitleAndSubtitle.trailingAnchor, constant: -10),
            
            // Constraints for subtitlePriceProduct
            subtitlePriceProduct.topAnchor.constraint(equalTo: titleNameProduct.bottomAnchor, constant: 5),
            subtitlePriceProduct.leadingAnchor.constraint(equalTo: viewTitleAndSubtitle.leadingAnchor, constant:  10),
            subtitlePriceProduct.trailingAnchor.constraint(equalTo: viewTitleAndSubtitle.trailingAnchor, constant:  -10),
            subtitlePriceProduct.bottomAnchor.constraint(equalTo: viewTitleAndSubtitle.bottomAnchor, constant:  -10)
        ])
    }
}
