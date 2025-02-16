//
//  WalktroughViewController.swift
//  Filmania-IOS
//
//  Created by Furkan Türkyaşar on 16.02.2025.
//

import UIKit
import Lottie

class WalktroughViewController: UIViewController {
    
    // MARK: - Properties
    
    private var currentPage = 0
    private let animations = ["0", "1", "2", "3"]
    
    // MARK: - UI Elements
    
    private lazy var animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        view.animationSpeed = 0.8
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = animations.count
        control.currentPage = 0
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = .label
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("İlerle", for: .normal)
        button.backgroundColor = .label
        button.setTitleColor(.systemGray5, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Atla", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
       let header = UILabel()
        header.numberOfLines = 0
        header.textAlignment = .center
        header.font = .systemFont(ofSize: 24, weight: .bold)
        header.textColor = .label
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGestures()
        showCurrentAnimation()
    }
    
}

// MARK: - Privates

private extension WalktroughViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(animationView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(headerLabel)
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            animationView.widthAnchor.constraint(equalToConstant: 300),
            animationView.heightAnchor.constraint(equalToConstant: 300),
            
            headerLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 32),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -32),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    func showCurrentAnimation(animated: Bool = true) {
        if animated {
            UIView.transition(with: animationView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                guard let self = self else { return }
                
                if let path = Bundle.main.path(forResource: self.animations[self.currentPage], ofType: "json") {
                    //print("Dosya yolu: \(path)")
                    self.animationView.animation = LottieAnimation.filepath(path)
                    self.animationView.play()
                    
                    setTexts()
                } else {
                    print("Dosya bulunamadı 0: \(self.animations[self.currentPage])")
                }
            })
        } else {
            if let path = Bundle.main.path(forResource: animations[currentPage], ofType: "json") {
                self.animationView.animation = LottieAnimation.filepath(path)
                self.animationView.play()
                
                setTexts()
            } else {
                print("Dosya bulunamadı 1: \(animations[currentPage])")
            }
        }
        
        pageControl.currentPage = currentPage
        
        UIView.transition(with: nextButton,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
            guard let self = self else { return }
            if self.currentPage == self.animations.count - 1 {
                self.nextButton.setTitle("Başla", for: .normal)
                self.skipButton.isHidden = true
            } else {
                self.nextButton.setTitle("İlerle", for: .normal)
                self.skipButton.isHidden = false
            }
        })
    }
    
    func setTexts() {
        switch currentPage {
            case 0:
                self.headerLabel.text = BaseConstant.WalktroughHeaders.page0
                self.textLabel.text = BaseConstant.WalktroughTexts.page0
            case 1:
                self.headerLabel.text = BaseConstant.WalktroughHeaders.page1
                self.textLabel.text = BaseConstant.WalktroughTexts.page1
            case 2:
                self.headerLabel.text = BaseConstant.WalktroughHeaders.page2
                self.textLabel.text = BaseConstant.WalktroughTexts.page2
            case 3:
                self.headerLabel.text = BaseConstant.WalktroughHeaders.page3
                self.textLabel.text = BaseConstant.WalktroughTexts.page3
            default:
                break
            }
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left && currentPage < animations.count - 1 {
            currentPage += 1
            showCurrentAnimation()
        } else if gesture.direction == .right && currentPage > 0 {
            currentPage -= 1
            showCurrentAnimation()
        }
    }
    
    @objc func nextButtonTapped() {
        if currentPage < animations.count - 1 {
            currentPage += 1
            showCurrentAnimation()
        } else {
            navigateToMainScreen(withAnimation: true)
        }
    }
    
    @objc func skipButtonTapped() {
        navigateToMainScreen(withAnimation: true)
    }
    
    func navigateToMainScreen(withAnimation: Bool) {
        UserDefaults.standard.set(true, forKey: "walkthroughCompleted")
        
        if withAnimation {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.alpha = 0
            }, completion: { _ in
                self.performNavigation()
            })
        } else {
            performNavigation()
        }
    }
    
    func performNavigation() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        let mainVC = ViewController()
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        
        delegate.window?.layer.add(transition, forKey: kCATransition)
        delegate.window?.rootViewController = mainVC
        delegate.window?.makeKeyAndVisible()
    }
}
