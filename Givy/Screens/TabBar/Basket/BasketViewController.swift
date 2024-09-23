//
//  BasketViewController.swift
//  Givy
//
//  Created by Max on 27.07.2024.
//

import UIKit

class BasketViewController: UIViewController {
    
    let customCell = CustomCell()
    
    private var product: [Pen] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.register(CustomCellView.self, forCellReuseIdentifier: "CustomCellView")
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var chekoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .colorButtonIsActive
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: #selector(tapChekoutButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc func tapChekoutButton() {
        let vc = NoteBookVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Basket Pen"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let apperance = UINavigationBarAppearance()
        apperance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = apperance
        
        let deleteButtonCustom = UIImage(systemName: "minus.circle")
        let deleteButton = UIBarButtonItem(image: deleteButtonCustom, style: .plain, target: self, action: #selector(tapDeleteButton))
        deleteButton.tintColor = .colorButtonIsActive
        navigationItem.rightBarButtonItem = deleteButton
        
        view.addSubview(chekoutButton)
        chekoutButtonConstrains()
        
        view.addSubview(tableView)
        createTableViewConstrains()
        
        product = Singleton.shared.pens
        tableView.reloadData()
    }
    
    private func createTableViewConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: chekoutButton.topAnchor),
        ])
    }
    
    private func chekoutButtonConstrains() {
        chekoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chekoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130),
            chekoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            chekoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            
            chekoutButton.heightAnchor.constraint(equalToConstant: 55)
            
        ])
    }
    
    @objc private func tapDeleteButton() {
        tableView.isEditing = !tableView.isEditing
        
        if tableView.isEditing {
            let customIcon = UIImage(systemName: "minus.circle.fill")
            let editIcon = UIBarButtonItem(image: customIcon, style: .plain, target: self, action: #selector(tapDeleteButton))
            editIcon.tintColor = .colorButtonIsActive
            navigationItem.rightBarButtonItem = editIcon
        } else {
            let customIcon = UIImage(systemName: "minus.circle")
            let editIcon = UIBarButtonItem(image: customIcon, style: .plain, target: self, action: #selector(tapDeleteButton))
            editIcon.tintColor = .gray
            navigationItem.rightBarButtonItem = editIcon
        }
    }
    
    func updateBadgeValue() {
        if let tabBarItems = tabBarController?.tabBar.items {
            let basketTabBarItem = tabBarItems[2]
            basketTabBarItem.badgeValue = "1"
        }
    }
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellView", for: indexPath) as? CustomCellView else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .white
    
        let array = Singleton.shared.pens
        let product = array[indexPath.row]
        
        let images: [UIImage] = [
            UIImage(named: "DialogBlueLight")!,
            UIImage(named: "DialogBlack")!,
            UIImage(named: "DialogWhite")!
        ]
        
        let image = images[indexPath.item]
        cell.customCell.image(image: image)
        cell.customCell.titleText(text: product.name)
        cell.customCell.subtitleText(text: "\(product.price)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let index = indexPath.row
            product.remove(at: index)
            
            Singleton.shared.removePen(at: index)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let badgeButton = self.tabBarController?.tabBar.viewWithTag(100) as? UIButton {
                
                badgeButton.setTitle("", for: .normal)
                badgeButton.backgroundColor = .clear
            }
        }
    }
}

#Preview {
    BasketViewController()
}
