//
//  Storage.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 23.04.2023.
//

import UIKit

final class Storage {
    static let shared = Storage()
    
    let defaults = UserDefaults.standard
    
    private init() {}
    
    // MARK: - Storage methods for check and load avatar for screen ForYouViewController
    func saveAvatar(image: Data, forKey: String) {
        defaults.set(image, forKey: forKey)
    }
    
    func getAvatar(forKey: String) -> Data? {
        guard let data = defaults.object(forKey: forKey) as? Data else { return nil}
        return data
    }
}
