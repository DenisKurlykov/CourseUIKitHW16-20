//
//  SelectedProductViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 22.03.2023.
//

import UIKit

final class SelectedProductViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productCoastLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet private var productColorAluminumLabel: UILabel!
    @IBOutlet private var productColorGrayLabel: UILabel!
    
    @IBOutlet var selectedProductOneImageView: UIImageView!
    @IBOutlet var selectedProductTwoImageView: UIImageView!
    
    // MARK: - Public Properties
    
    var model: Model?
    
    //MARK: - Private Properties
    
    private let productColorIsSelected: UIColor = .systemBlue
    private let productColorNotSelected: UIColor = .black
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tapProductColorAluminumLabel()
        tapProductColorGrayLabel()
        tapSelectedProductOneImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = .dark
    }
    
    // MARK: - Action
    
    private func tapSelectedProductOneImageView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(choiceAProductOne))
        selectedProductOneImageView.addGestureRecognizer(tap)
        selectedProductOneImageView.isUserInteractionEnabled = true
    }
    
    private func tapProductColorAluminumLabel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(choiceAluminumColor))
        productColorAluminumLabel.addGestureRecognizer(tap)
        productColorAluminumLabel.isUserInteractionEnabled = true
    }
    
    private func tapProductColorGrayLabel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(choiceGrayColor))
        productColorGrayLabel.addGestureRecognizer(tap)
        productColorGrayLabel.isUserInteractionEnabled = true
    }
}

// MARK: - SetupUI

private extension SelectedProductViewController {
    func setupUI() {
        //Setup view background color
        view.backgroundColor = .black
        
        //Setup Navigation Bar
        let sharedButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(sharedButtonPressed))
        let likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(likeButtonPressed))
        navigationItem.rightBarButtonItems = [likeButton, sharedButton]
        navigationController?.navigationBar.prefersLargeTitles = false
        
        //Setup Labels
        guard let model = model else { return }
        productNameLabel.text = model.description
        productCoastLabel.text = model.coast
        descriptionLabel.text = model.description
        productColorGrayLabel.layer.borderColor = productColorIsSelected.cgColor
    }
}

//MARK: - SetupSelector

private extension SelectedProductViewController {
    @objc func sharedButtonPressed() {
        
    }
    
    @objc func likeButtonPressed() {
        
    }
    
    @objc func choiceAluminumColor() {
        productColorGrayLabel.layer.borderColor = productColorNotSelected.cgColor
        productColorAluminumLabel.layer.borderColor = productColorIsSelected.cgColor
    }
    
    @objc func choiceGrayColor() {
        productColorAluminumLabel.layer.borderColor = productColorNotSelected.cgColor
        productColorGrayLabel.layer.borderColor = productColorIsSelected.cgColor
    }
    
    @objc func choiceAProductOne() {
        let vc = AboutSelectedProductViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}



