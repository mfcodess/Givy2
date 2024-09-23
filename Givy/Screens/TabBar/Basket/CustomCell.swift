//
//  CustomCell.swift
//  Givy
//
//  Created by Max on 18.08.2024.
//

import UIKit

class CustomCell: UIControl {
    
    var tap = false {
        didSet {
            update()
        }
    }
    
    let perplePen = PerplePen()
    
    private var checkBoxTab: UIImage {
        return tap ? UIImage(systemName: "checkmark.circle.fill")! : UIImage(systemName: "circle")!
    }
    
    private lazy var checkBox: UIButton = {
        let button = UIButton()
        button.setImage(checkBoxTab, for: .normal)
        button.tintColor = .colorButtonIsActive
        button.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapCheckBox), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        return button
    }()
    
    @objc private func tapCheckBox() {
        tap.toggle()
    }
    
    private lazy var imagePen: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var viewPen: UIView = {
        let view = UIView()
        view.backgroundColor = .colorGray
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imagePen)
        
        NSLayoutConstraint.activate([
            imagePen.topAnchor.constraint(equalTo: view.topAnchor),
            imagePen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagePen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imagePen.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            view.widthAnchor.constraint(equalToConstant: 100),
            view.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        return view
    }()
    
    private lazy var namePen: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    private lazy var nameCountry: UILabel = {
        let label = UILabel()
        label.text = "Germany"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var pricePen: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    //MARK: - StackViews
    private lazy var stackViewCheckBoxAndImagePen: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .center
        // stackView.backgroundColor = .blue
        
        stackView.addArrangedSubview(checkBox)
        stackView.addArrangedSubview(viewPen)
        
        return stackView
    }()
    
    private lazy var stackViewNamePenAndPricePen: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //stackView.spacing = -50
        stackView.distribution = .fillEqually
        // stackView.backgroundColor = .green
        
        stackView.addArrangedSubview(namePen)
        stackView.addArrangedSubview(nameCountry)
        stackView.addArrangedSubview(pricePen)
        
        return stackView
    }()
    
    private lazy var stackViewBasket: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        //stackView.backgroundColor = .red
        
        stackView.addArrangedSubview(stackViewCheckBoxAndImagePen)
        stackView.addArrangedSubview(stackViewNamePenAndPricePen)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackViewBasket)
        createStackViewBasketConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func image(image: UIImage) {
        imagePen.image = image
    }
    
    func titleText(text: String) {
        namePen.text = text
    }
    
    func subtitleText(text: String) {
        pricePen.text = text
    }
    
    func update() {
        checkBox.setImage(checkBoxTab, for: .normal)
        if tap {
            guard let image = imagePen.image,
                  let name = namePen.text,
                  let price = pricePen.text else {
                return
            }
            
            let selectedPen = Pen(image: image, name: name, price: price)
            
            let atributteTextTitle = NSMutableAttributedString(string: selectedPen.name)
            atributteTextTitle.strikeThrough(thickness: NSUnderlineStyle.single.rawValue, subString: selectedPen.name)
            namePen.attributedText = atributteTextTitle
            
            let atributteTextGermany = NSMutableAttributedString(string: "Germany")
            atributteTextGermany.strikeThrough(thickness: NSUnderlineStyle.single.rawValue, subString: "Germany")
            nameCountry.attributedText = atributteTextGermany
            
            let atributteTextPrice = NSMutableAttributedString(string: selectedPen.price)
            atributteTextPrice.strikeThrough(thickness: NSUnderlineStyle.single.rawValue, subString: selectedPen.price)
            pricePen.attributedText = atributteTextPrice
        } else {
            namePen.attributedText = NSAttributedString(string: namePen.text ?? "")
            pricePen.attributedText = NSAttributedString(string: pricePen.text ?? "")
            nameCountry.attributedText = NSAttributedString(string: nameCountry.text ?? "")
        }
    }
}

extension CustomCell {
    private func createStackViewBasketConstrains() {
        stackViewBasket.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewBasket.topAnchor.constraint(equalTo: topAnchor),
            stackViewBasket.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewBasket.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewBasket.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackViewBasket.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension CustomCell {
    func saveImageToUserDefaults() {
        let userDefaults = UserDefaults.standard
        
        if let imageData = imagePen.image?.pngData() {
            userDefaults.set(imageData, forKey: "savedImage")
        }
    }
    
    func loadImageFromUserDefaults() {
        let userDefaults = UserDefaults.standard

        if let imageData = userDefaults.data(forKey: "savedImage"),
           let image = UIImage(data: imageData) {
            imagePen.image = image
        }
    }
}

#Preview {
    CustomCell()
}
