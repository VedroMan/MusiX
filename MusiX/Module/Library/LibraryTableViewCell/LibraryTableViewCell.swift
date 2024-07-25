//
//  LibraryTableViewCell.swift
//  MusiX
//
//  Created by Timofey on 16.07.24.
//

import UIKit

class LibraryTableViewCell: UITableViewCell, CellProtocols {
    static var reuseId: String = "LibraryTableViewCell"
    
    private lazy var songIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "music.note")
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var songName: UILabel = {
        let name = UILabel()
        name.text = "title"
        name.font = .systemFont(ofSize: 19, weight: .medium)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var autorName: UILabel = {
        let autorName = UILabel()
        autorName.text = "Autor name"
        autorName.font = .systemFont(ofSize: 15, weight: .regular)
        autorName.textColor = AppColors.Gray
        autorName.translatesAutoresizingMaskIntoConstraints = false
        return autorName
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [songIcon, songName, autorName].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        backgroundColor = .white
        NSLayoutConstraint.activate([
            //setup constraints for songIcon
            songIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            songIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            songIcon.heightAnchor.constraint(equalToConstant: 50),
            songIcon.widthAnchor.constraint(equalToConstant: 50),
            
            //setup constraints for songName
            songName.centerYAnchor.constraint(equalTo: songIcon.centerYAnchor, constant: -8),
            songName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            songName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            //setup constraints for autorTitle
            autorName.centerYAnchor.constraint(equalTo: songIcon.centerYAnchor, constant: 12),
            autorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            autorName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        ])
    }
    func configure(contact: (image: UIImage?, title: String)) {
        songIcon.image = contact.image
        songName.text = contact.title
    }
}

#Preview { TabBarViewController() }
