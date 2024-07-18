//
//  PlayerViewController.swift
//  MusiX
//
//  Created by Timofey on 14.07.24.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    //setup playerLabel
    private lazy var playerTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Player"
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //setup slider
    private lazy var musicSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.value = 0.0
        slider.maximumValue = 100.0
        slider.isContinuous = true
        slider.tintColor = AppColors.mainRed
//        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.backgroundColor = .green
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: -- Setup Layer
private extension PlayerViewController {
    func setup() {
        view.backgroundColor = AppColors.lightGrayMain
        setupConstraints()
    }
    //setupConstraints
    func setupConstraints() {
        view.addSubview(playerTitle)
        view.addSubview(musicSlider)
        NSLayoutConstraint.activate([
            //setup constraints for playerTitle
            playerTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            playerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            playerTitle.heightAnchor.constraint(equalToConstant: 40),
            
            //setup constraints for slider
            musicSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            musicSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            musicSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            musicSlider.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
}
#Preview { TabBarViewController() }
#Preview { PlayerViewController() }
