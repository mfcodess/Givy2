//
//  BluePen.swift
//  Givy
//
//  Created by Max on 02.08.2024.
//

import UIKit

class BluePen: UIViewController {
    
    private lazy var titleInfo = createTitleInfo()
    private lazy var subtitleInfo = createSubtitleInfo()
    private lazy var stackViewLabels = createStackViewLabels()
    
    private lazy var titleColor = createTitleColor()
    
    private lazy var stackViewTitleColors = createStackViewTitleColors()
    
    private lazy var imagePen = createImagePen()
    private lazy var blueButton = createCircleBlue()
    private lazy var whiteButton = createCircleWhite()
    private lazy var blackButton = createCircleBlack()
    private lazy var stackViewButtonsColors = createStackViewButtonsColors()
    
    private var bluewBorderColor: UIView?
    private var whiteBorderColor: UIView?
    private var blackBorderColor: UIView?
    
    var resultOtvet: Double = 17.57
    private lazy var titlePrice = createTitlePrice()
    private lazy var stepper = CustomStepper()
    private lazy var addToCardButton = createAddToCardButton()
    
    private lazy var stackViewPriceAndStepper = createStackViewPriceAndStepper()
    private lazy var stackViewPriceAndStepperAndAddToCard = createStackViewPriceAndStepperAndAddToCard()
    
    var basePrice: Double = 17.57 {
        didSet {
            updateTitlePrice()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(imagePen)
        createImageBluewConstrains()
        
        view.addSubview(stackViewLabels)
        createStackViewLabelsConstrains()
        
        view.addSubview(stackViewTitleColors)
        createStackViewsColorsButtonConstrains()
        
        view.addSubview(stackViewButtonsColors)
        createStackViewButtonsColorsConstrains()
        
        view.addSubview(stackViewPriceAndStepperAndAddToCard)
        createStackViewPriceAndStepperAndAddToCardConstrains()
        
        stepper.delegate = self
    }
    
    func updateTitlePrice() {
        titlePrice.text = String(format: "$ %.2f", basePrice)
    }
}

private extension BluePen {
    
    func createTitleInfo() -> UILabel {
        let text = UILabel()
        text.text = "LAMY AL-Star Aquatic"
        text.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        text.numberOfLines = 0
        text.textColor = .black
        
        return text
    }
    
    func createSubtitleInfo() -> UILabel {
        let text = UILabel()
        text.text = "Small and comfortable, Pico first reveals its potential when tasted on a leaf."
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.numberOfLines = 0
        text.textColor = .gray
        
        return text
    }
    
    func createStackViewLabels() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        
        stackView.addArrangedSubview(titleInfo)
        stackView.addArrangedSubview(subtitleInfo)
        
        return stackView
    }
    
    func createTitleColor() -> UILabel {
        let text = UILabel()
        text.text = "Selected Colors"
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.numberOfLines = 0
        text.textColor = .black
        
        return text
    }
    
    func createCircleBlue() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .colorBlue
        button.layer.cornerRadius = 21
        button.addTarget(self, action: #selector(tapButtonPerple), for: .touchUpInside)
        
        let viewBorder = UIView()
        viewBorder.layer.borderWidth = 2.0
        viewBorder.layer.borderColor = UIColor.gray.cgColor
        viewBorder.layer.cornerRadius = 30
        viewBorder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewBorder)
        
        NSLayoutConstraint.activate([
            viewBorder.topAnchor.constraint(equalTo: view.topAnchor, constant: 296),
            viewBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11),
            viewBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -304),
            viewBorder.widthAnchor.constraint(equalToConstant: 60),
            viewBorder.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        bluewBorderColor = viewBorder
        
        return button
    }
    
    func createCircleWhite() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .colorGray
        button.layer.cornerRadius = 21
        button.addTarget(self, action: #selector(tapButtonRed), for: .touchUpInside)
        
        let viewBorder = UIView()
        viewBorder.layer.borderWidth = 0
        viewBorder.layer.borderColor = UIColor.gray.cgColor
        viewBorder.layer.cornerRadius = 30
        viewBorder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewBorder)
        
        NSLayoutConstraint.activate([
            viewBorder.topAnchor.constraint(equalTo: view.topAnchor, constant: 296),
            viewBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 73),
            viewBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -241),
            
            viewBorder.widthAnchor.constraint(equalToConstant: 60),
            viewBorder.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        whiteBorderColor = viewBorder
        
        return button
    }
    
    func createCircleBlack() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 21
        button.addTarget(self, action: #selector(tapButtonGreen), for: .touchUpInside)
        
        let viewBorder = UIView()
        viewBorder.layer.borderWidth = 0
        viewBorder.layer.borderColor = UIColor.gray.cgColor
        viewBorder.layer.cornerRadius = 30
        viewBorder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewBorder)
        
        NSLayoutConstraint.activate([
            viewBorder.topAnchor.constraint(equalTo: view.topAnchor, constant: 296),
            viewBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 135),
            viewBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -179),
            
            viewBorder.widthAnchor.constraint(equalToConstant: 60),
            viewBorder.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        blackBorderColor = viewBorder
        
        return button
    }
    
    func createStackViewTitleColors() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(titleColor)
        
        return stackView
    }
    
    func createImagePen() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "DialogBlueLight")
        
        return image
    }
    
    func createStackViewButtonsColors() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        //stackView.backgroundColor = .red
        stackView.spacing = 20
        
        stackView.addArrangedSubview(blueButton)
        stackView.addArrangedSubview(whiteButton)
        stackView.addArrangedSubview(blackButton)
        
        return stackView
    }
    
    func createTitlePrice() -> UILabel {
        let title = UILabel()
        title.text = String(format: "$ %.2f", resultOtvet)
        title.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        title.textColor = .black
        return title
    }
    
    func createAddToCardButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .colorButtonIsActive
        button.setTitle("Add to cart", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapButtonAddToCard), for: .touchUpInside)
        
        return button
    }
    
    func createStackViewPriceAndStepper() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 25
        
        stackView.addArrangedSubview(titlePrice)
        stackView.addArrangedSubview(stepper)
        
        return stackView
    }
    
    func createStackViewPriceAndStepperAndAddToCard() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        
        stackView.addArrangedSubview(stackViewPriceAndStepper)
        stackView.addArrangedSubview(addToCardButton)
        
        return stackView
    }
    
    //MARK: - Constrains
    func createStackViewLabelsConstrains() {
        stackViewLabels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewLabels.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 52),
            stackViewLabels.trailingAnchor.constraint(equalTo: imagePen.trailingAnchor, constant: -100),
            stackViewLabels.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
    
    func createStackViewsColorsButtonConstrains() {
        stackViewTitleColors.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewTitleColors.topAnchor.constraint(equalTo: stackViewLabels.bottomAnchor, constant: 30),
            stackViewTitleColors.trailingAnchor.constraint(equalTo: imagePen.leadingAnchor),
            stackViewTitleColors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func createImageBluewConstrains() {
        imagePen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imagePen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imagePen.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            imagePen.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func createStackViewButtonsColorsConstrains() {
        stackViewButtonsColors.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewButtonsColors.topAnchor.constraint(equalTo: stackViewTitleColors.bottomAnchor, constant: 20),
            stackViewButtonsColors.trailingAnchor.constraint(equalTo: imagePen.leadingAnchor, constant: -68),
            stackViewButtonsColors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewButtonsColors.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func createStackViewPriceAndStepperAndAddToCardConstrains() {
        stackViewPriceAndStepperAndAddToCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewPriceAndStepperAndAddToCard.trailingAnchor.constraint(equalTo: imagePen.leadingAnchor, constant: -50),
            stackViewPriceAndStepperAndAddToCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewPriceAndStepperAndAddToCard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            
            stepper.heightAnchor.constraint(equalToConstant: 55),
            addToCardButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func setupButtons(sender: UIView) {
        
        switch sender.tag {
        case 0:
            bluewBorderColor?.layer.borderWidth = 2.0
            whiteBorderColor?.layer.borderWidth = 0
            blackBorderColor?.layer.borderWidth = 0
        case 1:
            bluewBorderColor?.layer.borderWidth = 0
            whiteBorderColor?.layer.borderWidth = 2.0
            blackBorderColor?.layer.borderWidth = 0
        case 2:
            bluewBorderColor?.layer.borderWidth = 0
            whiteBorderColor?.layer.borderWidth = 0
            blackBorderColor?.layer.borderWidth = 2.0
        default:
            break
        }
    }
    
    //MARK: @objc
    @objc func tapButtonPerple(sender: UIView) {
        sender.tag = 0
        imagePen.image = UIImage(named: "DialogBlueLight")
        setupButtons(sender: sender)
    }
    
    @objc func tapButtonRed(sender: UIView) {
        sender.tag = 1
        imagePen.image = UIImage(named: "DialogWhite")
        setupButtons(sender: sender)
    }
    
    @objc func tapButtonGreen(sender: UIView) {
        sender.tag = 2
        imagePen.image = UIImage(named: "DialogBlack")
        setupButtons(sender: sender)
    }
    
    @objc func tapButtonAddToCard() {
        print("resultOtvet: \(resultOtvet)")
        let message: String
        if resultOtvet == 0 {
            message = "Select Pen"
        } else {
            message = """
                    Thank you for your purchase price: $\(resultOtvet)
                    """
            
            let selectedPen = Pen(image: UIImage(named: "DialogBlueLight")!, name: "AL-Star Aquatic", price: "$ \(resultOtvet)")
            
            Singleton.shared.addPen(pen: selectedPen)
            print("Добавили ручку в Singleton")
        }
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffetUIView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffetUIView.frame = view.bounds
        
        let alertController = UIAlertController(title: "Purchase: AL-Star Aquatic", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            blurVisualEffetUIView.removeFromSuperview()
            
            if let tabBarVC = self.tabBarController {
                
                let badgeButton = UIButton()
                badgeButton.tag = 100
                badgeButton.backgroundColor = .systemRed
                badgeButton.layer.cornerRadius = 10
                badgeButton.translatesAutoresizingMaskIntoConstraints = false
                badgeButton.setTitle("\(Singleton.shared.pens.count)", for: .normal)
                badgeButton.tintColor = .white
                badgeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
                
                tabBarVC.tabBar.addSubview(badgeButton)
                
                NSLayoutConstraint.activate([
                    badgeButton.bottomAnchor.constraint(equalTo: tabBarVC.tabBar.bottomAnchor, constant: -60),
                    badgeButton.trailingAnchor.constraint(equalTo: tabBarVC.tabBar.trailingAnchor, constant: -105),
                    badgeButton.widthAnchor.constraint(equalToConstant: 20),
                    badgeButton.heightAnchor.constraint(equalToConstant: 20)
                ])
            }
        }))
        
        view.addSubview(blurVisualEffetUIView)
        present(alertController, animated: true)
    }
}

extension BluePen: CustomButtonDelegate {
    func tap(value: Int) {
        print(value)
        resultOtvet = Double(value) * basePrice
        titlePrice.text = String(format: "$ %.2f", resultOtvet)
    }
}

#Preview  {
    BluePen()
}
