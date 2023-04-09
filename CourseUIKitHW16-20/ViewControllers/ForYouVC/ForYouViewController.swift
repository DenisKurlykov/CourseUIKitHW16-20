//
//  ForYouViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 13.03.2023.
//

import UIKit
import PhotosUI

private struct Const {
    /// Image height/width for Large NavBar state
    static let ImageSizeForLargeState: CGFloat = 40
    /// Margin from right anchor of safe area to right anchor of Image
    static let ImageRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ImageBottomMarginForLargeState: CGFloat = 12
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ImageBottomMarginForSmallState: CGFloat = 6
    /// Image height/width for Small NavBar state
    static let ImageSizeForSmallState: CGFloat = 32
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}

final class ForYouViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet var currentDeliveryProductView: UIView!
    
    // MARK: - Private Properties
    
    let personPhoto = UIImageView()
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = .light
        setupTabBar()
        setupCurrentDeliveryProductViewShadow()
        addImageToNavBar()
        setupPersonPhoto()
        
        setupRecognizer()
    }
    
    // MARK: - Setup GestureRecognizer
    
    private func setupRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToPersonPhoto))
        personPhoto.addGestureRecognizer(tap)
    }
    
    // MARK: - Setup Selector
    
    @objc func tapToPersonPhoto() {
        alertToSelectAPhotoSource(
            title: "Выберите Источник") { [weak self] in
                guard let self = self else { return }
                setupPHPicker()

            } completionGallery: { [weak self] in
                guard let self = self else { return }
                setupPHPicker()
            }
    }
    
    // MARK: - Setup UI
    
    private func setupTabBar() {
        
        tabBarController?.tabBar.backgroundColor = .white
    }
    
    private func addImageToNavBar() {
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(personPhoto)
        personPhoto.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        personPhoto.clipsToBounds = true
        personPhoto.layer.borderWidth = 1
        personPhoto.layer.borderColor = UIColor.gray.cgColor
        personPhoto.contentMode = .scaleAspectFit
        personPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personPhoto.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            personPhoto.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            personPhoto.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            personPhoto.widthAnchor.constraint(equalTo: personPhoto.heightAnchor)
        ])
    }
    
    private func setupPersonPhoto() {
        personPhoto.isUserInteractionEnabled = true
        personPhoto.layer.masksToBounds = true
        personPhoto.contentMode = .scaleAspectFill
    }
    
    private func setupCurrentDeliveryProductViewShadow() {
        currentDeliveryProductView.layer.cornerRadius = 15
        
        currentDeliveryProductView.layer.shadowColor = UIColor.gray.cgColor
        currentDeliveryProductView.layer.shadowOpacity = 0.5
        currentDeliveryProductView.layer.shadowRadius = 10
        currentDeliveryProductView.layer.shadowOffset = CGSize(width: 0, height: 10)
        
    }
    
    private func setupPHPicker() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - PHPickerViewControllerDelegate

extension ForYouViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    personPhoto.image = image
                }
            }
        }
    }
}
