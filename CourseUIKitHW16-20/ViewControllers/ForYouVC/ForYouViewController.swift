//
//  ForYouViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 13.03.2023.
//

import UIKit
import PhotosUI

final class ForYouViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var currentDeliveryProductView: UIView!
    
    // MARK: - Private Properties
    
    private let personPhoto = UIImageView()
    
    // MARK: - Override Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
        setupCurrentDeliveryProductViewShadow()
        addImageToNavBar()
        setupPersonPhoto()
        
        setupRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = .light
        setupTabBar()
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
                getPhotoFromCamera()
                
            } completionGallery: { [weak self] in
                guard let self = self else { return }
                getPhotoFromLibrary()
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
        personPhoto.layer.cornerRadius = Const.ImageSizeForLargeState.rawValue / 2
        personPhoto.clipsToBounds = true
        personPhoto.layer.borderWidth = 1
        personPhoto.layer.borderColor = UIColor.gray.cgColor
        personPhoto.contentMode = .scaleAspectFit
        personPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personPhoto.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin.rawValue),
            personPhoto.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState.rawValue),
            personPhoto.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState.rawValue),
            personPhoto.widthAnchor.constraint(equalTo: personPhoto.heightAnchor)
        ])
    }
    
    private func setupPersonPhoto() {
        personPhoto.isUserInteractionEnabled = true
        personPhoto.layer.masksToBounds = true
        personPhoto.contentMode = .scaleAspectFill
        
        if Storage.shared.getAvatar(forKey: "PHOTO") == nil {
            personPhoto.image = UIImage(systemName: "person")
        } else {
            guard let data = UserDefaults.standard.data(forKey: "PHOTO") else { return }
            do {
                let decoded = try PropertyListDecoder().decode(Data.self, from: data)
                let image = UIImage(data: decoded)
                personPhoto.image = image
            } catch {
                return
            }
            
        }
    }
    
    private func setupCurrentDeliveryProductViewShadow() {
        currentDeliveryProductView.layer.cornerRadius = 15
        
        currentDeliveryProductView.layer.shadowColor = UIColor.gray.cgColor
        currentDeliveryProductView.layer.shadowOpacity = 0.5
        currentDeliveryProductView.layer.shadowRadius = 10
        currentDeliveryProductView.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    private func getPhotoFromLibrary() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func getPhotoFromCamera() {
        let myPickerControllerCamera = UIImagePickerController()
        myPickerControllerCamera.delegate = self
        myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
        myPickerControllerCamera.allowsEditing = true
        present(myPickerControllerCamera, animated: true)
    }
}

// MARK: - PHPickerViewControllerDelegate

extension ForYouViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage,
                      error == nil,
                      let data = image.pngData()
                else { return }
                
                do {
                    let encoded = try PropertyListEncoder().encode(data)
                    //UserDefaults.standard.set(encoded, forKey: "PHOTO")
                    Storage.shared.saveAvatar(image: encoded, forKey: "PHOTO")
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        personPhoto.image = image
                    }
                    
                } catch {
                    return
                }
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ForYouViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let photo = info[.originalImage] as? UIImage else { return }
        personPhoto.image = photo
        
        dismiss(animated: true)
    }
}

// MARK: - Image size for navigationBar

extension ForYouViewController {
    enum Const: CGFloat {
        /// Image height/width for Large NavBar state
        case ImageSizeForLargeState = 40
        /// Margin from right anchor of safe area to right anchor of Image
        case ImageRightMargin = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        case ImageBottomMarginForLargeState = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        case ImageBottomMarginForSmallState = 6
        /// Image height/width for Small NavBar state
        case ImageSizeForSmallState = 32
        /// Height of NavBar for Small state. Usually it's just 44
        case NavBarHeightSmallState = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        case NavBarHeightLargeState = 96.5
    }
}
