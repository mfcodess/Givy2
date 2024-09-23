//
//  MainViewController.swift
//  Givy
//
//  Created by Max on 27.07.2024.
//

import UIKit

struct Product {
    let image: String
    let name: String
    let price: String
}

class MainViewController: UIViewController {
    
    private var timer: Timer?
    private let cards: [String] = ["LamyViewOne",
                                   "LamyViewTwo",
                                   "LamyViewThree"]
    
    private var products: [Product] = [
        Product(image: "DialogBlueLight", name: "AL-Star Aquatic", price: "$ 47.85"),
        Product(image: "Perple", name: "Special Safari Field", price: "$ 17.57"),
        Product(image: "Blue", name: "Nexx Fountain", price: "$ 16.82"),
        Product(image: "Brown", name: "Studio Dark", price: "$ 59.09"),
        Product(image: "GreenLight", name: "AL-Star Turmaline", price: "$ 10.33"),
        Product(image: "BlueStar", name: "Balloon 2.0", price: "$ 8.47"),
        Product(image: "scala dark", name: "Scala dark", price: "$ 36.53"),
        Product(image: "Xevo", name: "Xevo", price: "$ 11.78")
    ]
    
    private lazy var collectionViewHeader: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.bounces = false
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MainHeaderCollectionViewCell.self, forCellWithReuseIdentifier: MainHeaderCollectionViewCell.id)
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    private lazy var collectionViewProduct: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 25
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(MainProductCollectionViewCell.self, forCellWithReuseIdentifier: MainProductCollectionViewCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customViewNavigation)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupViews()
        createCollectionViewHeaderConstrains()
        startTimer()
        createCollectionViewProductConstrains()
        
        collectionViewHeader.reloadData()
        collectionViewProduct.reloadData()
    }

    deinit {
        timer?.invalidate()
    }
    
    func setupViews() {
        view.addSubview(collectionViewHeader)
        view.addSubview(collectionViewProduct)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextItem() {

        let getCell = collectionViewHeader.indexPathsForVisibleItems
       
        let firstCell = getCell.first
        let nextCell = IndexPath(item: (firstCell?.item ?? 0) + 1, section: 0)
        if nextCell.item < collectionViewHeader.numberOfItems(inSection: 0) {
            collectionViewHeader.scrollToItem(at: nextCell, at: .centeredHorizontally, animated: true)
        } else {
            collectionViewHeader.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension MainViewController {
    
    func createCollectionViewHeaderConstrains() {
        NSLayoutConstraint.activate([
            collectionViewHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionViewHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewHeader.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    func createCollectionViewProductConstrains() {
        NSLayoutConstraint.activate([
            collectionViewProduct.topAnchor.constraint(equalTo: collectionViewHeader.bottomAnchor, constant: 20),
            collectionViewProduct.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionViewProduct.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionViewProduct.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewHeader {
            cards.count
        } else {
            products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewHeader {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainHeaderCollectionViewCell.id, for: indexPath) as! MainHeaderCollectionViewCell
            cell.configure(image: cards[indexPath.row])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainProductCollectionViewCell.id, for: indexPath) as! MainProductCollectionViewCell
            
            let product = products[indexPath.row]
            cell.setupProduct(image: product.image, title: product.name, subtitle: product.price)
            
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionViewProduct {
            switch indexPath.row {
            case 0:
                let vc = BluePen()
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = PerplePen()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        } else {
            switch indexPath.row {
            case 0:
                let vc = PerplePen()
                navigationController?.present(vc, animated: true)
            case 1:
                let vc = BluePen()
                navigationController?.present(vc, animated: true)
            default:
                break
            }
        }
    }
}

//MARK: - UICollectionViewFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewHeader {
            let width = collectionView.frame.width
            let height: CGFloat = collectionView.frame.height
            
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: view.frame.width / 2 - 30, height: 200)
        }
    }
}

#Preview {
    MainViewController()
}
