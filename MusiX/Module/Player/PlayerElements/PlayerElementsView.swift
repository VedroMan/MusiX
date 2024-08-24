//
//  PlayerElemetsViewController.swift
//  MusiX
//
//  Created by Tim Zykov on 23/08/2024.
//

import UIKit

class PlayerElementsView: UIView {
    
    lazy var trackImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "music.note")
        image.tintColor = AppColors.mainRed
        image.backgroundColor = .systemGray4
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.text = "Track Name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var autorLabel: UILabel = {
        let label = UILabel()
        label.text = "Autor Name"
        label.textColor = AppColors.mainRed
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
}

//MARK: -- Setup Constraints
private extension PlayerElementsView {
    
    func setup() {
        addSubview(trackLabel)
        addSubview(trackImage)
        addSubview(autorLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            trackImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            trackImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            trackImage.heightAnchor.constraint(equalToConstant: 350),
            trackImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.93),
            
            trackLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            trackLabel.topAnchor.constraint(equalTo: trackImage.bottomAnchor, constant: 3),
            
            autorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            autorLabel.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 3)
        ])
    }
    
}

//MARK: -- UI Update functions

extension PlayerElementsView {
    
    func updateTrackImage(with image: UIImage?) {
        trackImage.image = image ?? UIImage(systemName: "music.note")
    }
    
    func updateTrackName(to name: String) {
        trackLabel.text = name
    }
    
    func updateArtistName(to name: String) {
        autorLabel.text = name
    }
    
}
