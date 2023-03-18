//
//  UIView+extentsion.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 18.03.2023.
//

import UIKit

extension UIView {
    func addSubviewsUIView(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
}
