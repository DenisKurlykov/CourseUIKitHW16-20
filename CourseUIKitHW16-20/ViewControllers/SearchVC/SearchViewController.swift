//
//  SearchViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 13.03.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let clearButton = UIButton(type: .system)
    
    private lazy var recentlyViewedLabels = label(text: "Недавно просмотренные", fontSize: 22)
    private lazy var requestOptionsLabel = label(text: "Варианты запросов", fontSize: 22)
    
    private let productCardOneView = ProductCard(
        textLabel: """
Беспроводные наушники
Apple AirPods Max,
серебристый
""",
        textSize: 15,
        imageName: "Airpods Max_1"
    )
    
    private lazy var firstLineSearchTextField = textField(text: "AirPods", textSize: 22)
    private lazy var secondLineSearchTextField = textField(text: "AppleCare", textSize: 22)
    private lazy var thirdLineSearchTextField = textField(text: "Beats", textSize: 22)
    private lazy var fourthLineSearchTextField = textField(text: "Beats", textSize: 22)
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
        setupNavigationBar()
        setupClearButton()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        title = "Поиск"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Поиск по продуктам и магазинам"
    }
    
    private func setupClearButton() {
        clearButton.setTitle("Очистить", for: .normal)
        clearButton.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
}

// MARK: - SetupUI

private extension SearchViewController {
    func setupUI() {
        addSubviews(
            recentlyViewedLabels,
            clearButton,
            productCardOneView,
            requestOptionsLabel,
            firstLineSearchTextField,
            secondLineSearchTextField,
            thirdLineSearchTextField,
            fourthLineSearchTextField
        )
        
        setupConstraints()
    }
    
    func setupConstraints() {
        [
            recentlyViewedLabels,
            clearButton,
            productCardOneView,
            requestOptionsLabel,
            firstLineSearchTextField,
            secondLineSearchTextField,
            thirdLineSearchTextField,
            fourthLineSearchTextField
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            recentlyViewedLabels.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recentlyViewedLabels.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            clearButton.centerYAnchor.constraint(equalTo: recentlyViewedLabels.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            productCardOneView.heightAnchor.constraint(equalToConstant: 200),
            productCardOneView.widthAnchor.constraint(equalToConstant: 150),
            productCardOneView.topAnchor.constraint(equalTo: recentlyViewedLabels.bottomAnchor, constant: 16),
            productCardOneView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            requestOptionsLabel.topAnchor.constraint(equalTo: productCardOneView.bottomAnchor, constant: 32),
            requestOptionsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            firstLineSearchTextField.topAnchor.constraint(equalTo: requestOptionsLabel.bottomAnchor, constant: 8),
            firstLineSearchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            secondLineSearchTextField.topAnchor.constraint(equalTo: firstLineSearchTextField.bottomAnchor, constant: 8),
            secondLineSearchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            thirdLineSearchTextField.topAnchor.constraint(equalTo: secondLineSearchTextField.bottomAnchor, constant: 8),
            thirdLineSearchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            fourthLineSearchTextField.topAnchor.constraint(equalTo: thirdLineSearchTextField.bottomAnchor, constant: 8),
            fourthLineSearchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8)
        ])
    }
}
