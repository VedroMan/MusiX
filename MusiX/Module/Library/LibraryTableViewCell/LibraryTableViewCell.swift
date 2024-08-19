//
//  LibraryTableViewCell.swift
//  MusiX
//
//  Created by Timofey on 16.07.24.
//

import UIKit

class LibraryTableViewCell: UITableViewCell, CellProtocols {
    
    static var reuseId: String = "LibraryTableViewCell"
    
    private lazy var trackIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "music.note")
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var trackName: UILabel = {
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
        [trackIcon, trackName, autorName].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        backgroundColor = .white
        NSLayoutConstraint.activate([
            //setup constraints for songIcon
            trackIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trackIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            trackIcon.heightAnchor.constraint(equalToConstant: 50),
            trackIcon.widthAnchor.constraint(equalToConstant: 50),
            
            //setup constraints for songName
            trackName.centerYAnchor.constraint(equalTo: trackIcon.centerYAnchor, constant: -8),
            trackName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            trackName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            //setup constraints for autorTitle
            autorName.centerYAnchor.constraint(equalTo: trackIcon.centerYAnchor, constant: 12),
            autorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            autorName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        ])
    }
    func configure(contact: (image: UIImage?, track: String, artist: String)) {
        trackIcon.image = contact.image
        trackName.text = contact.track
        autorName.text = contact.artist
    }
}
