//
//  SearchViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 13.03.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let model = Model.getModel()
    
    private let clearButton = UIButton(type: .system)
    
    private lazy var recentlyViewedLabels = label(text: "Недавно просмотренные", fontSize: 22)
    private lazy var requestOptionsLabel = label(text: "Варианты запросов", fontSize: 22)
    
    private lazy var productCardOneView = ProductCard(
        textLabel: model[0].name,
        textSize: 15,
        imageName: model[0].imageName
    )
    private lazy var productCardTwoView = ProductCard(
        textLabel: model[1].name,
        textSize: 15,
        imageName: model[1].imageName
    )
    private lazy var productCardThreeView = ProductCard(
        textLabel: model[2].name,
        textSize: 15,
        imageName: model[2].imageName
    )
    
    private lazy var firstLineSearchTextField = textField(text: "AirPods", textSize: 22)
    private lazy var secondLineSearchTextField = textField(text: "AppleCare", textSize: 22)
    private lazy var thirdLineSearchTextField = textField(text: "Beats", textSize: 22)
    private lazy var fourthLineSearchTextField = textField(text: "Beats", textSize: 22)
    
    private lazy var productScrollView = UIScrollView()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupClearButton()
        setupUI()
        setupScrollView()
        setupTapGestureRecognizer()
    }
    
    // MARK: - Action
    
    private func setupTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openSelectedVC))
        productCardOneView.addGestureRecognizer(tap)
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
    
    private func setupScrollView() {
        productScrollView.contentSize = CGSize(width: 158 * 3, height: 200)
        productScrollView.isPagingEnabled = false
        productScrollView.showsHorizontalScrollIndicator = false
        productScrollView.addSubview(productCardOneView)
        productScrollView.addSubview(productCardTwoView)
        productScrollView.addSubview(productCardThreeView)
    }
}

// MARK: - SetupUI

private extension SearchViewController {
    func setupUI() {
        view.backgroundColor = .black
        
        addSubviews(
            recentlyViewedLabels,
            clearButton,
            productCardOneView,
            productCardTwoView,
            productCardThreeView,
            requestOptionsLabel,
            firstLineSearchTextField,
            secondLineSearchTextField,
            thirdLineSearchTextField,
            fourthLineSearchTextField,
            productScrollView
        )
        
        setupConstraints()
    }
    
    func setupConstraints() {
        [
            recentlyViewedLabels,
            clearButton,
            productCardOneView,
            productCardTwoView,
            productCardThreeView,
            requestOptionsLabel,
            firstLineSearchTextField,
            secondLineSearchTextField,
            thirdLineSearchTextField,
            fourthLineSearchTextField,
            productScrollView
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            recentlyViewedLabels.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recentlyViewedLabels.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            clearButton.centerYAnchor.constraint(equalTo: recentlyViewedLabels.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            productScrollView.heightAnchor.constraint(equalToConstant: 200),
            productScrollView.topAnchor.constraint(equalTo: recentlyViewedLabels.bottomAnchor, constant: 16),
            productScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            productScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            productCardOneView.heightAnchor.constraint(equalToConstant: 200),
            productCardOneView.widthAnchor.constraint(equalToConstant: 150),
            productCardOneView.topAnchor.constraint(equalTo: productScrollView.bottomAnchor, constant: 4),
            productCardOneView.leadingAnchor.constraint(equalTo: productScrollView.leadingAnchor, constant: 4),
            
            productCardTwoView.heightAnchor.constraint(equalToConstant: 200),
            productCardTwoView.widthAnchor.constraint(equalToConstant: 150),
            productCardTwoView.topAnchor.constraint(equalTo: productScrollView.bottomAnchor, constant: 4),
            productCardTwoView.leadingAnchor.constraint(equalTo: productCardOneView.trailingAnchor, constant: 8),
            
            productCardThreeView.heightAnchor.constraint(equalToConstant: 200),
            productCardThreeView.widthAnchor.constraint(equalToConstant: 150),
            productCardThreeView.topAnchor.constraint(equalTo: productScrollView.bottomAnchor, constant: 4),
            productCardThreeView.leadingAnchor.constraint(equalTo: productCardTwoView.trailingAnchor, constant: 8),
            
            requestOptionsLabel.topAnchor.constraint(equalTo: productScrollView.bottomAnchor, constant: 32),
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

// MARK: - Setup Selector

private extension SearchViewController {
    @objc func openSelectedVC() {
        let storyboard = UIStoryboard(name: "SelectedProduct", bundle: nil)
        guard
            let nextVC = storyboard.instantiateViewController(withIdentifier: "SelectedProductVC") as? SelectedProductViewController
        else
        {
            return
        }
        nextVC.model = model[0]
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
