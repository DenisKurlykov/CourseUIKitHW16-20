//
//  ForYouViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 13.03.2023.
//

import UIKit

final class ForYouViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = .light
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBarController?.tabBar.backgroundColor = .white
    }
}
