//
//  ForYouViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 13.03.2023.
//

import UIKit

final class ForYouViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet var currentDeliveryProductView: UIView!
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = .light
        setupTabBar()
        setupShadow()
    }
    
    // MARK: - Private Method
    
    private func setupTabBar() {
        tabBarController?.tabBar.backgroundColor = .white
    }
    
    private func setupShadow() {
        currentDeliveryProductView.layer.cornerRadius = 15
        
        currentDeliveryProductView.layer.shadowColor = UIColor.gray.cgColor
        currentDeliveryProductView.layer.shadowOpacity = 0.5
        currentDeliveryProductView.layer.shadowRadius = 10
        currentDeliveryProductView.layer.shadowOffset = CGSize(width: 0, height: 10)
    
    }
}
