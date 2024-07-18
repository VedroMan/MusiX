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
        name.font = .systemFont(ofSize: 20, weight: .medium)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [songIcon, songName].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        backgroundColor = .white
        NSLayoutConstraint.activate([
            //setup constraints for songIcon
            songIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            songIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            songIcon.heightAnchor.constraint(equalToConstant: 50),
            songIcon.widthAnchor.constraint(equalToConstant: 53),
            
            //setup constraints for songName
            songName.centerYAnchor.constraint(equalTo: songIcon.centerYAnchor),
            songName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            songName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        ])
    }
    func configure(contact: (image: UIImage?, title: String)) {
        songIcon.image = contact.image
        songName.text = contact.title
    }
}

#Preview { TabBarViewController() }
