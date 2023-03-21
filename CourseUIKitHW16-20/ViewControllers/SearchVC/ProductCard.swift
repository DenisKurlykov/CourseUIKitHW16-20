//
//  File.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 15.03.2023.
//

import UIKit
 
final class ProductCard: UIView {
    
    // MARK: - Private Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    // MARK: - Initializer
    
    init(textLabel: String, textSize: CGFloat, imageName: String) {
        super .init(frame: .zero)
        setupUI(textLabel: textLabel, textSize: textSize, imageName: imageName)
        
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    // MARK: - Private Methods
    
    private func setupUI(textLabel: String, textSize: CGFloat, imageName: String) {
        backgroundColor = UIColor(red: 32/255, green: 28/255, blue: 34/255, alpha: 1)
        layer.cornerRadius = 20
        
        label.text = textLabel
        label.font = .systemFont(ofSize: textSize)
        imageView.image = UIImage(named: imageName)
        
        addSubviewsUIView(
            imageView,
            label
        )
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        [
            imageView,
            label
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 125),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
