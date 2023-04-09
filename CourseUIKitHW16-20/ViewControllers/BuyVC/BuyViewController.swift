//
//  BuyViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 13.03.2023.
//

import UIKit

final class BuyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.backgroundColor = UIColor(red: 18/255.0, green: 18/255.0, blue: 18/255.0, alpha: 1)
    }
}
