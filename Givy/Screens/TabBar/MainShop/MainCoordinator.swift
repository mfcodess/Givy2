//
//  MainCoordinator.swift
//  Givy
//
//  Created by Max on 27.07.2024.
//

import UIKit

final class MainCoordinator {
    private let navigationController: UINavigationController
    private let vc = TabBarViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
}
