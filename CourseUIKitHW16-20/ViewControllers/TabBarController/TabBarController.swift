//
//  ViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 13.03.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }

    private func createTabBar() {
        let forYouStoryboard = UIStoryboard(name: "ForYou", bundle: nil)
        
        let buyVC = BuyViewController()
        let forYouVC = forYouStoryboard.instantiateViewController(identifier: "ForYouVC")
        let searchVC = SearchViewController()
        let shoppingCartVC = ShoppingCartViewController()
        
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        
        buyVC.tabBarItem = UITabBarItem(title: "Купить", image: UIImage(systemName: "laptopcomputer.and.iphone"), tag: 0)
        forYouVC.tabBarItem = UITabBarItem(title: "Для вас", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        searchVC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        shoppingCartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "bag"), tag: 3)
        
        tabBar.tintColor = .systemBlue
        
        tabBar.unselectedItemTintColor = .gray
        
        viewControllers = [buyVC, forYouVC, searchNavVC, shoppingCartVC]
        
        selectedIndex = 2
    }
}

