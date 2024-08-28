//
//  SettingsTableViewCell.swift
//  MusiX
//
//  Created by Tim Zykov on 22/08/2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "SettingsTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "title"
        title.textColor = .black
        title.font = .systemFont(ofSize: 20, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private lazy var titleIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "folder")
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [titleLabel, titleIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        backgroundColor = .white
        NSLayoutConstraint.activate([
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 100),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            titleIcon.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            titleIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleIcon.heightAnchor.constraint(equalToConstant: 39),
            titleIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(contact: (image: UIImage?, title: String)) {
        titleLabel.text = contact.title
        titleIcon.image = contact.image
    }
}

#Preview {SettingsViewController()}
