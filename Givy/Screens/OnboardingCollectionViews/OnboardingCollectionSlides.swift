//
//  CollectionViews.swift
//  Givy
//
//  Created by Max on 18.07.2024.
//

import UIKit

class OnboardingCollectionViews: UIViewController {
    
    //MARK: - Private properties
    
    ///CollectionView
    private lazy var collectionView = createCollectionView()
    
    ///Buttons
    private lazy var skipButton = createSkipButton()
    private lazy var nextButton = createNextButton()
    
    ///Pagers
    var pagers: [UIView] = []
    
    ///StackViews
    private lazy var stackViewHorizontal = createStackViewHorizontal()
    private lazy var stackViewPagers = createStackViewPagers()
    private lazy var stackViewPagersAndNextButtonHorizontal = createStackViewHorizontalSkipButtonAndNextButton()
    
    ///Create Info Slide
    private var slide = 0
    
    ///Create Width
    private var widthAnchor: NSLayoutConstraint?
    
    ///Create Shape
    private let shape = CAShapeLayer()
    private var currentPageIndex: CGFloat = 0
    private var fromValue: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createPagers()
        view.addSubview(collectionView)
        view.addSubview(stackViewHorizontal)
        
        createCollectionViewConstrains()
        createStackViewHorizontalConstrains()
        createStackViewHorizontalSkipButtonAndNextButtonConstrains()
        
        setShape()
        
        guard let navigationController else {
            return
        }
        
        mainCoordinator = MainCoordinator(navigationController: navigationController)
    }
    
    // MARK: - Private
    
    private var mainCoordinator: MainCoordinator?
}

//MARK: - Createn CollectionViews
private extension OnboardingCollectionViews {
    
    ///Create CollectionView
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 540)
        layout.minimumLineSpacing = 0 
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(OnboardingCollectionViewsCustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }
    
    ///Create CollectionViewConstrains
    func createCollectionViewConstrains() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: stackViewHorizontal.topAnchor, constant: -20)
        ])
    }
    
    ///Create Button Skip
    func createSkipButton() -> UIButton {
        let skip = UIButton()
        skip.setTitle("Skip", for: .normal)
        skip.setTitleColor(.gray, for: .normal)
        skip.backgroundColor = .colorGray
        skip.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        skip.layer.cornerRadius = 20
        skip.translatesAutoresizingMaskIntoConstraints = false
        skip.addTarget(self, action: #selector(tapSkipButton), for: .touchUpInside)
        
        return skip
    }
    
    //MARK: - Create Tap Skip Button
    @objc func tapSkipButton() {
//        let vc = RegistrationViewController()
//        navigationController?.pushViewController(vc, animated: true)
        
        mainCoordinator?.start()
    }
    
    ///Create Button Next
    func createNextButton() -> UIButton {
        let image = UIImage(systemName: "arrow.right")
        let next = UIButton(type: .system)
        let changeSizeImage = image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))
        
        next.setImage(changeSizeImage, for: .normal)
        next.tintColor = .white
        next.backgroundColor = .standardColorBlack
        next.layer.cornerRadius = 30
        next.translatesAutoresizingMaskIntoConstraints = false
        
        next.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        
        return next
    }
    
    ///Create Pagers
    func createPagers() {
        for element in 1...3 {
            let view = UIView()
            view.backgroundColor = .standardColorBlack
            view.layer.cornerRadius = 6
            view.tag = element
            view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 11),
                view.heightAnchor.constraint(equalToConstant: 11),
            ])
            
            pagers.append(view)
        }
    }
    
    ///Create StackView Horizontal
    func createStackViewHorizontal() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //stackView.backgroundColor = .gray
        stackView.spacing = 100
        stackView.alignment = .center
        
        stackView.addArrangedSubview(skipButton)
        stackView.addArrangedSubview(stackViewPagersAndNextButtonHorizontal)
        
        return stackView
    }
    
    ///Create StackView Horizontal Constrains
    func createStackViewHorizontalConstrains() {
        stackViewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewHorizontal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            
            stackViewHorizontal.heightAnchor.constraint(equalToConstant: 90),
            
            skipButton.heightAnchor.constraint(equalToConstant: 40),
            skipButton.widthAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    ///Create StackView Horizontal SkipButton And Next Button
    func createStackViewHorizontalSkipButtonAndNextButton() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        //stackView.backgroundColor = .red
        stackView.spacing = 35
        
        stackView.addArrangedSubview(stackViewPagers)
        stackView.addArrangedSubview(nextButton)
        
        return stackView
    }
    
    ///Create StackView Horizontal SkipButton And Next Button Constrains
    func createStackViewHorizontalSkipButtonAndNextButtonConstrains() {
        stackViewPagersAndNextButtonHorizontal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 61),
            nextButton.widthAnchor.constraint(equalToConstant: 61),
        ])
    }
    
    func createStackViewPagers() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        
        //stackView.backgroundColor = .green
        
        for element in pagers {
            stackView.addArrangedSubview(element)
        }
        
        return stackView
    }
    
    
    //MARK: - Create Set Shape
    func setShape() {
        currentPageIndex = CGFloat(1) / CGFloat(pagers.count)
        
        let nextStroke = UIBezierPath(arcCenter: CGPoint(x: 30.5, y: 30.5), radius: 35, startAngle: -(.pi / 2), endAngle: 5, clockwise: true)
        
        let trackShape = CAShapeLayer()
        trackShape.path = nextStroke.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 3
        trackShape.strokeColor = UIColor.gray.cgColor
        trackShape.opacity = 0.1
        nextButton.layer.addSublayer(trackShape)
        
        shape.path = nextStroke.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.standardColorBlack.cgColor
        shape.lineWidth = 4
        shape.lineCap = .round
        shape.strokeStart = 0
        shape.strokeEnd = 0
        
        nextButton.layer.addSublayer(shape)
    }
    
    //MARK: Create Tap Next Button
        @objc func tapNextButton() {
            let maxSlide = pagers.count - 1
            
            if slide < maxSlide {
                slide += 1
                collectionView.scrollToItem(at: IndexPath(item: slide, section: 0), at: .centeredHorizontally, animated: true)
            } else if slide == maxSlide {
//                let vc = RegistrationViewController()
//                navigationController?.pushViewController(vc, animated: true)
                mainCoordinator?.start()
            }
        }
    }

extension OnboardingCollectionViews: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCollectionViewsCustomCell
        
        switch indexPath.item {
        case 0:
            let attributedText = NSMutableAttributedString(string: "Availability Of Purchases, For Your Comfort!")
            attributedText.setTextColor(color: .colorImages, toSubstring: "Availability")
            attributedText.setTextColor(color: .colorImages, toSubstring: "Purchases")
            
            cell.setup(model: CellModel(imageName: "OnbordingOne", attributedTitle: attributedText, subtitle: "Purchases that will always bring you joy and enjoyment, right at your fingertips."))
        case 1:
            let attributedText = NSMutableAttributedString(string: "When You Receive The Product, You Get Emotions")
            attributedText.setTextColor(color: .colorImages, toSubstring: "Receive")
            attributedText.setTextColor(color: .colorImages, toSubstring: "Emotions")
            
            cell.setup(model: CellModel(imageName: "OnbordingTwo", attributedTitle: attributedText, subtitle: "Emotions are an important part of our work, which we strive to convey to you."))
        case 2:
            let attributedText = NSMutableAttributedString(string: "The Best Products Only In Our Store")
            attributedText.setTextColor(color: .colorImages, toSubstring: "The Best")
            attributedText.setTextColor(color: .colorImages, toSubstring: "In Our Store")
            
            cell.setup(model: CellModel(imageName: "OnbordingThree", attributedTitle: attributedText, subtitle: "Products that always delight our customers and bring pleasure every time."))
        default:
            break
        }
        
        return cell
    }
}

extension OnboardingCollectionViews: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        slide = indexPath.item
        updatePageIndicators(forItemAt: indexPath)
        animateShape(forItemAt: indexPath)
    }
    
    private func updatePageIndicators(forItemAt indexPath: IndexPath) {
        for page in pagers {
            let tag = page.tag
            let viewTag = indexPath.row + 1
            
            for constraint in page.constraints {
                page.removeConstraint(constraint)
            }
            
            if viewTag == tag {
                page.layer.opacity = 1
                widthAnchor = page.widthAnchor.constraint(equalToConstant: 20)
            } else {
                page.layer.opacity = 0.5
                widthAnchor = page.widthAnchor.constraint(equalToConstant: 12)
            }
            
            widthAnchor?.isActive = true
            page.heightAnchor.constraint(equalToConstant: 12).isActive = true
        }
    }
    
    private func animateShape(forItemAt indexPath: IndexPath) {
        let currentIndex = currentPageIndex * CGFloat(indexPath.item + 1)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = currentIndex
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.duration = 0.5
        shape.add(animation, forKey: "animation")
        
        fromValue = currentIndex
    }
}

#Preview {
    OnboardingCollectionViews()
}
