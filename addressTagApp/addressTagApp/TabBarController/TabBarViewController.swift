//
//  TabBarViewController.swift
//  addressTagApp
//
//  Created by Leonardo Cunha on 07/09/25.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarUI()
        viewControllers = [
            createHomeViewController(),
            createAgendaViewController()
        ]
        selectedIndex = 0
    }

    func createHomeViewController() -> UIViewController {
        let viewController = HomeViewController()
        viewController.tabBarItem.title = "Novo"
        return viewController
    }
    
    func createAgendaViewController() -> UIViewController {
        let viewController = AgendaViewController()
        viewController.tabBarItem.title = "Agenda"
        return viewController
    }
    
    func setupTabBarUI() {
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.tintColor = .systemBlue
    }
}
