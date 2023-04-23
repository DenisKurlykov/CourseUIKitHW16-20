//
//  PageViewController.swift
//  CourseUIKitHW16-20
//
//  Created by Денис Курлыков on 17.04.2023.
//

import UIKit

final class PageViewController: UIPageViewController {
    
    // MARK: - Data for visual component
    private enum Data {
        /// Название изображения первого экрана
        static let firstScreenImageName = "productSelection"
        /// Текст первого экрана
        static let firstScreenLabelText = "Большой выбор товара"
        /// Название изображения второго экрана
        static let secondScreenImageName = "deliveryProduct"
        /// Текст второго экрана
        static let secondScreenLabelText = "Доставка из ближайших магазинов"
        /// Название изображения третьего экрана
        static let thirdScreenImageName = "productOrder"
        /// Текст третьего экрана
        static let thirdScreenLabelText = "Заходите и выбирайте"
        /// текст лейбла кнопки next
        static let nameButtonNext = "next"
        /// текст лейбла кнопки  skip
        static let nameButtonSkip = "skip"
        /// текст лейбла кнопки start
        static let nameButtonStart = "start"
    }
    
    // MARK: - Visual components
    private let skipButton = UIButton()
    private let nextButton = UIButton()
    private let startButton = UIButton()
    
    // MARK: - Private properties
    let pageControl = UIPageControl.appearance()
    
    // Текущей индекс
    var currentIndex = 0
    
    // Массив данных
    private let onboardingScreens = [
        ModelOnboarding(imageName: Data.firstScreenImageName, titleText: Data.firstScreenLabelText),
        ModelOnboarding(imageName: Data.secondScreenImageName, titleText: Data.secondScreenLabelText),
        ModelOnboarding(imageName: Data.thirdScreenImageName, titleText: Data.thirdScreenLabelText)
    ]
    // Создание массива экранов инициализированных данными
    private lazy var onboardingScreenViewController:[OnboardingScreenViewController] = {
        var screens = [OnboardingScreenViewController]()
        // Перебираем массив с данными onboardingScreens
        for screen in onboardingScreens {
            // инициализируем экран данными и добавляем в массив
            screens.append(OnboardingScreenViewController(model: screen))
        }
        return screens
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupPageController()
        createTarget()
    }
    
    // MARK: - Init
    // инициализируем PageViewController
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        view.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
        
        // Назначаем экран для первого экрана PageVC
        setViewControllers([onboardingScreenViewController[0]], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    // Метод скрывает все компоненты UIPageVC в данном случае единственным элементом являеются точки
    private func componentsPageVC(isHidden: Bool) {
        // перебираем все элементы подвида и проверяем являются ли они элементами UIPageControl
        for subView in view.subviews where subView is UIPageControl {
            // если да то присваиваем значение переданное в метод
            subView.isHidden = isHidden
        }
    }
}

// MARK: - Setup action
private extension PageViewController {
    func createTarget() {
        skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    @objc func skipButtonPressed() {
        Storage.shared.saveOnboarding(forKey: "onboarding")
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func nextButtonPressed() {
        guard let currentVC = viewControllers?.first,
              let nextVC = dataSource?.pageViewController(self, viewControllerAfter: currentVC) else { return }
        if nextVC == onboardingScreenViewController.last {
            nextButton.isHidden = true
            skipButton.isHidden = true
            startButton.isHidden = false
            componentsPageVC(isHidden: true)
        }
        setViewControllers([nextVC], direction: .forward, animated: true)
    }
    
    @objc func startButtonPressed() {
        Storage.shared.saveOnboarding(forKey: "onboarding")
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - Setup Visual components
private extension PageViewController {
    func setupUI() {
        addSubviews(
            skipButton,
            nextButton,
            startButton
        )
        
        setupSkipButton()
        setupNextButton()
        setupConstraints()
        setupStartButton()
    }
    
    func setupSkipButton() {
        skipButton.setTitle(Data.nameButtonSkip, for: .normal)
        skipButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        skipButton.setTitleColor(.gray, for: .normal)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupNextButton() {
        nextButton.setTitle(Data.nameButtonNext, for: .normal)
        nextButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        nextButton.setTitleColor(.systemBlue, for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStartButton() {
        startButton.setTitle(Data.nameButtonStart, for: .normal)
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        startButton.setTitleColor(.black, for: .normal)
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.layer.cornerRadius = 10
        startButton.isHidden = true
        startButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            startButton.heightAnchor.constraint(equalToConstant: 35),
            startButton.widthAnchor.constraint(equalToConstant: 75),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }
}

// MARK: - Setup PageViewController
private extension PageViewController {
    func setupPageController() {
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .gray
    }
}

// MARK: - UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // берем экран который отображается в данный момент и кастим его до экрана нашего типа
        guard let vc = viewController as? OnboardingScreenViewController,
              // узнаем индекс отображаемого экрана в массиве экранов
              let index = onboardingScreenViewController.firstIndex(of: vc),
              // если индекс текущего экрана больше 0 то мы можем перейти назад и показать новый экран
              index > 0 else { return nil }
        // от индекса текущего экрана отнимаем единицу
        currentIndex -= 1
        // отображаем предыдущий экран
        return onboardingScreenViewController[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? OnboardingScreenViewController,
              let index = onboardingScreenViewController.firstIndex(of: vc),
              index < onboardingScreenViewController.count - 1 else { return nil }
        currentIndex += 1
        return onboardingScreenViewController[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        // отображаем количество точек равное кол-ву элементов массива
        onboardingScreenViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentIndex
    }
}

// MARK: - UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    // метод делегата который позволяет определить какой контроллер будет отображен следующим при
    // возникновении действия(прокрутки)
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        // получаем экран который планируется отобразить
        guard let pendingVC = pendingViewControllers.first,
              // кастим этот экран до значения нашего контролера
              let vc = pendingVC as? OnboardingScreenViewController,
              // проверяем, какой индекс имеет данный экрана в массиве
              let index = onboardingScreenViewController.firstIndex(of: vc) else { return }
        
        switch index {
        case onboardingScreenViewController.indices.last:
            nextButton.isHidden = true
            skipButton.isHidden = true
            startButton.isHidden = false
            componentsPageVC(isHidden: true)

        default:
            nextButton.isHidden = false
            skipButton.isHidden = false
            startButton.isHidden = true
            componentsPageVC(isHidden: false)

        }
    }
}
