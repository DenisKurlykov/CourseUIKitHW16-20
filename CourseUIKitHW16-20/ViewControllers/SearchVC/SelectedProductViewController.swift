//
//  SelectedProductViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 22.03.2023.
//

import UIKit

final class SelectedProductViewController: UIViewController {
    
    private var likeButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let sharedButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(sharedButtonPressed))
        likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(likeButtonPressed))
        navigationItem.rightBarButtonItems = [likeButton, sharedButton]
        navigationController?.navigationBar.prefersLargeTitles = false
        
    
        
    }
    
    @objc private func sharedButtonPressed() {
        
    }
    
    @objc private func likeButtonPressed() {
        
    }
}
