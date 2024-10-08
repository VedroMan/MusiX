//
//  TabBarViewController.swift
//  MusiX
//
//  Created by Timofey on 10.07.24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let tabs: [(image: UIImage?, title: String)] = [
    (UIImage(systemName: "magnifyingglass"), String("Search")),
    (UIImage(systemName: "music.note.list"), String("Library")),
    (UIImage(systemName: "play.circle"), String("Player")),
    (UIImage(systemName: "gearshape"), String("Settings"))
    
  ]
    private var tabButtons: [UIButton] = []
    
    private lazy var tabBarView: UIView = {
        let barView = UIView()
        barView.backgroundColor = .white
        barView.translatesAutoresizingMaskIntoConstraints = false
        return barView
    }()
    
    lazy var selectedItem = UIAction { [weak self] sender in
        guard
            let self = self,
            let sender = sender.sender as? UIButton
        else { return }
        
        self.updateButtonColors(selectedButton: sender)
        self.selectedIndex = sender.tag
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 1
        updateButtonColors(selectedButton: tabButtons[selectedIndex])
    }
}

//MARK: --Setup Layer

private extension TabBarViewController {
    
    func setup() {
        
        setupTapBarButton()
        setControllers()
        
    }
    
    //create tap bar button
    func createTabBarButton(icon: UIImage, title: String, tag: Int) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = icon
        config.title = title
        config.imagePadding = 2
        config.imagePlacement = .top
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = .systemFont(ofSize: 11, weight: .bold)
        attributedTitle.foregroundColor = .white
        
        config.attributedTitle = attributedTitle
        
        let button = UIButton(configuration: config, primaryAction: selectedItem)
        button.tag = tag
        button.tintColor = AppColors.Gray
        return button
    }
    
    //setup bar button
    func setupTapBarButton() {
        let stackView = UIStackView(frame: tabBarView.bounds)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        tabs.enumerated().forEach{ index, tab in
            guard let image = tab.image else { return }
            
            let tabButton = createTabBarButton(icon: image, title: tab.title, tag: index)
            tabButtons.append(tabButton)
            stackView.addArrangedSubview(tabButton)
        }
        
        view.addSubview(tabBarView)
        view.addSubview(stackView)
        
        setupConstraints(stack: stackView)
    }
    
    //Setup constaints for stack
    func setupConstraints(stack: UIStackView) {
        NSLayoutConstraint.activate([
            //setup constraints for TabBarView
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 40),
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 90),
            
            //setup constraints for stack in TabBarView located in UIStackView(tabBarView)
            stack.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: -35),
            stack.topAnchor.constraint(equalTo: tabBarView.topAnchor)
        ])
    }
    
    //Setup ViewControllers
    func setControllers() {
        let playerVC = PlayerViewController()
        let libraryVC = LibraryViewController()
        let searchVC = SearchViewController()
        let settingsVC = SettingsViewController()
        
        libraryVC.delegate = playerVC
        
        setViewControllers([searchVC, libraryVC, playerVC, settingsVC], animated: true)
    }
    
    //setup updateButtonColors
    func updateButtonColors(selectedButton: UIButton) {
        tabButtons.forEach{ $0.tintColor = AppColors.Gray }
        selectedButton.tintColor = AppColors.mainRed
    }
}

#Preview {TabBarViewController()}
