//
//  TabBarViewController.swift
//  Givy
//
//  Created by Max on 27.07.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .colorButtonIsActive
        tabBar.backgroundColor = .standardColorBlack

        let mainVC = MainViewController()
        let searchVC = SearchViewController()
        let basketVC = BasketViewController()
        
        let aboutVC: UIViewController
        if let _ = UserDefaultsManager.shared.getEmail() {
            aboutVC = AboutViewController()
        } else {
            aboutVC = RegistrationViewController()
        }

        let homeImage = UIImage(named: "Home")?.withRenderingMode(.alwaysTemplate).resizeImage(to: CGSize(width: 30, height: 30))
        let searchImage = UIImage(named: "Search")?.withRenderingMode(.alwaysTemplate).resizeImage(to: CGSize(width: 30, height: 30))
        let basketImage = UIImage(named: "Basket")?.withRenderingMode(.alwaysTemplate).resizeImage(to: CGSize(width: 30, height: 30))
        let aboutImage = UIImage(named: "About")?.withRenderingMode(.alwaysTemplate).resizeImage(to: CGSize(width: 30, height: 30))

        let navigationVCMain = UINavigationController(rootViewController: mainVC)
        navigationVCMain.tabBarItem = UITabBarItem(title: "", image: homeImage, tag: 0)
        
        let navigationVCSearch = UINavigationController(rootViewController: searchVC)
        navigationVCSearch.tabBarItem = UITabBarItem(title: "", image: searchImage, tag: 1)
        
        let navigationVCBasket = UINavigationController(rootViewController: basketVC)
        navigationVCBasket.tabBarItem = UITabBarItem(title: "", image: basketImage, tag: 2)
        
        let navigationVCAbout = UINavigationController(rootViewController: aboutVC)
        navigationVCAbout.tabBarItem = UITabBarItem(title: "", image: aboutImage, tag: 3)

        viewControllers = [navigationVCMain, navigationVCSearch, navigationVCBasket, navigationVCAbout]

        
    }
}

extension UIImage {

    func resizeImage(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

#Preview {
    TabBarViewController()
}
