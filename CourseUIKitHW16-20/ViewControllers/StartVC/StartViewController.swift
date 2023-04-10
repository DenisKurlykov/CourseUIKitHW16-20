//
//  StartViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 09.04.2023.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet var appDownloadScale: UIProgressView!
    
    private var timer = Timer()
    var counter: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
    }
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(updateProgressView),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func updateProgressView() {
        if appDownloadScale.progress != 1.0 {
            counter += 0.025
            appDownloadScale.setProgress(counter, animated: true)
        } else if appDownloadScale.progress == 1.0 {
            timer.invalidate()
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}
