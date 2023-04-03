//
//  AboutSelectedProductViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 31.03.2023.
//

import UIKit
import WebKit

final class AboutSelectedProductViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let url = "https://www.icases.ru/catalog/kompyutery-noutbuki/chekhly-dlya-macbook/chekhly-dlya-macbook-pro-13-touch-bar/chekhol-incase-facet-sleeve-dlya-macbook-air-13-macbook-pro-13-seryy-inmb100680-gry/"
    
    private var currentUrl: String?
    
    private let webView = WKWebView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private let toolBar = UIToolbar()
    private let backButtonItem = UIBarButtonItem()
    private let forwardButtonItem = UIBarButtonItem()
    private let flexibleSpace = UIBarButtonItem()
    private let refreshButton = UIBarButtonItem()
    private let sharedButton = UIBarButtonItem()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        createUrlRequest()
        setupUI()
        setupToolBar()
        setupConstraints()
        setupActivityIndicator()
        
    }
    
    // MARK: - Action
    
    @objc private func doneButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc private func backButtonItemPressed() {
        guard webView.canGoBack else { return }
        webView.goBack()
    }
    
    @objc private func forwardButtonItemPressed() {
        guard webView.canGoForward else { return }
        webView.goForward()
    }
    
    @objc private func refreshButtonPressed() {
        webView.reload()
    }
    
    @objc private func sharedButtonPressed() {
        if let currentUrl {
            print(currentUrl)
            let activity = UIActivityViewController(activityItems: [currentUrl], applicationActivities: nil)
            present(activity, animated: true)
        }
    }
}

// MARK: - SetupUI

private extension AboutSelectedProductViewController {
    func createUrlRequest() {
        guard let myUrl = URL(string: url) else { return }
        let myRequest = URLRequest(url: myUrl)
        webView.load(myRequest)
        
        webView.navigationDelegate = self
    }
    
    func setupUI() {
        view.backgroundColor = .black
        
        addSubviews(
            webView,
            toolBar,
            activityIndicator
        )
    }
    
    func setupNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.leftBarButtonItem = doneButton
        
    }
    
    func setupToolBar() {
        let backButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(backButtonItemPressed))
        let forwardButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(forwardButtonItemPressed))
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonPressed))
        let sharedButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "square.and.arrow.up"), target: self, action: #selector(sharedButtonPressed))
        
        toolBar.items = [backButtonItem, forwardButtonItem, refreshButton, flexibleSpace, sharedButton]
        
    }
    
    func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .systemBlue
        activityIndicator.hidesWhenStopped = true
    }
    
    func setupConstraints() {
        [
            webView,
            toolBar,
            activityIndicator
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            toolBar.topAnchor.constraint(equalTo: webView.bottomAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - WKNavigationDelegate

extension AboutSelectedProductViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        backButtonItem.isEnabled = false
        forwardButtonItem.isEnabled = false
        refreshButton.isEnabled = false
        sharedButton.isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        refreshButton.isEnabled = true
        sharedButton.isEnabled = true
        
        if webView.canGoForward {
            forwardButtonItem.isEnabled = true
        } else if webView.canGoBack {
            backButtonItem.isEnabled = true
        }
        
        currentUrl = webView.url?.absoluteString
    }
}

