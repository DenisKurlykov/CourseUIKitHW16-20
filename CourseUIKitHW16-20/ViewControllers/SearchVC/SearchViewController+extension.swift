//
//  SearchViewController+extension.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 15.03.2023.
//

import UIKit

extension SearchViewController {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    func label(text: String, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: fontSize)
        return label
    }
    
    func textField(text: String, textSize: CGFloat) -> UITextField {
        let textField = UITextField()
        let searchImage = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchImage.tintColor = .white
        textField.borderStyle = .roundedRect
        textField.text = text
        textField.font = .systemFont(ofSize: textSize)
        textField.textColor = .white
        textField.leftView = searchImage
        textField.leftViewMode = .always
        return textField
    }
}
