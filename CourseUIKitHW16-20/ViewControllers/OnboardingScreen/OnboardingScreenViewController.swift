//
//  OnboardingScreenViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 17.04.2023.
//

import UIKit

final class OnboardingScreenViewController: UIViewController {
    
    // MARK: - Create visual component
    private let image = UIImageView()
    private let label = UILabel()
    
    // MARK: - Init ModelOnboarding
    private let modelOnboarding: ModelOnboarding
    
    init(model: ModelOnboarding) {
        self.modelOnboarding = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupImage()
        setupLabel()
        setupConstraints()
    }
}

// MARK: - Setup visual component
private extension OnboardingScreenViewController {
        
    
    func setupImage() {
        image.image = UIImage(named: modelOnboarding.imageName)
        image.contentMode = .scaleAspectFit
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLabel() {
        label.text = modelOnboarding.titleText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Setup Constraints
private extension OnboardingScreenViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250),
            NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150),
            NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            
            
            NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: image, attribute: .bottom, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 350),
            
        ])
    }
}
