//
//  TabBarViewController.swift
//  MusiX
//
//  Created by Timofey on 10.07.24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let tabs: [(image: UIImage?, title: String)] = [
    (UIImage(systemName: "folder"), String("Search")),
    (UIImage(systemName: "book"), String("Library")),
    (UIImage(systemName: "folder"), String("Player")),
    (UIImage(systemName: "gearshape"), String("Settings"))
    
  ]
    private var tabButtons: [UIButton] = []
    
    private lazy var tabBarView: UIView = {
        let barView = UIView()
        barView.backgroundColor = .purple
        barView.translatesAutoresizingMaskIntoConstraints = false
        return barView
    }()
    
    lazy var selectedItem = UIAction { [weak self] sender in
        guard
            let self = self,
            let sender = sender.sender as? UIButton
        else { return }
        
//        self.updateButtonColors
        self.selectedIndex = sender.tag
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupTapBarButton()
        setControllers()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 1
//        updateButtonColors(selectedButton: tabButtons[selectedIndex])
    }
}

//MARK: ->Setup Layer

private extension TabBarViewController {
    
    //create tap bar button
    func createTabBarButton(icon: UIImage, title: String, tag: Int) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = icon
        config.title = title
        config.imagePadding = 3
        config.imagePlacement = .top
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = .systemFont(ofSize: 9, weight: .light)
        attributedTitle.foregroundColor = .white
        
        config.attributedTitle = attributedTitle
        
        let button = UIButton(configuration: config, primaryAction: selectedItem)
        button.tag = tag
        button.tintColor = .lightGray
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
            tabBarView.topAnchor.constraint(equalTo: view.topAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 100),
            
            //setup constraints for stack in TabBarView located in UIStackView(tabBarView)
            stack.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 20)
        ])
    }
    
    //Setup ViewControllers
    func setControllers() {
        let controllers = [
        SearchViewController(),
        LibraryViewController(),
        PlayerViewController(),
        SettingsViewController()
        ]
        
        setViewControllers([controllers[0],controllers[1],controllers[2],controllers[3]], animated: true)
    }
}
