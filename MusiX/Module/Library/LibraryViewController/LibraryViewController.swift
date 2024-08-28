//
//  LibraryViewController.swift
//  MusiX
//
//  Created by Tim Zykov on 14.07.24.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private var tapGesture: UITapGestureRecognizer?
    
    weak var delegate: LibraryViewControllerDelegate?
    
    private lazy var libraryCell: [(image: UIImage?, track: String, artist: String)] = [
         (UIImage(systemName: "music.note"), "haunted4" , "4elovek"),
         (UIImage(systemName: "music.note"), "Baby, You're A Rich Man" , "The beatles"),
         (UIImage(systemName: "music.note"), "Ameli" , "Big Baby Tape"),
         (UIImage(systemName: "music.note"), "Lose Yourself" , "Eminem"),
         (UIImage(systemName: "music.note"), "Mockingbird" , "Eminem"),
         (UIImage(systemName: "music.note"), "Let It Happen" , "Tame Impala")
         
    ]
    
    // setup titleTopView
    private lazy var topTitleView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    // setup goToPlaylistsButton
    private lazy var goToPlaylistsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Playlists", for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // setup tableView
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(LibraryTableViewCell.self, forCellReuseIdentifier: LibraryTableViewCell.reuseId)
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = true
        table.layer.cornerRadius = 0
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: -- Setup Layer
private extension LibraryViewController {
    
    func setup() {
        view.backgroundColor = AppColors.lightGrayMain
        setupConstraints()
    }
    
    // setupConstraints
    func setupConstraints() {
        view.addSubview(topTitleView)
        view.addSubview(tableView)
        view.addSubview(goToPlaylistsButton)
        NSLayoutConstraint.activate([
            
            // setup constraints for libraryTitle
            topTitleView.topAnchor.constraint(equalTo: view.topAnchor),
            topTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topTitleView.heightAnchor.constraint(equalToConstant: 100),
            
            // setup constraints for tableView
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            // setup constraints for goToPlaylistsButton
            goToPlaylistsButton.heightAnchor.constraint(equalToConstant: 40),
            goToPlaylistsButton.widthAnchor.constraint(equalToConstant: 200),
            goToPlaylistsButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -30),
            goToPlaylistsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            
        ])
    }
}

//MARK: -- UITableViewDataSource, UITableViewDelegate
extension LibraryViewController: UITableViewDataSource, UITableViewDelegate {
    
    //number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        libraryCell.count
    }
    
    //number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    //row in cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewCell.reuseId, for: indexPath) as! LibraryTableViewCell
        let item = libraryCell[indexPath.section]
        cell.configure(contact: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTrack = libraryCell[indexPath.section]
                
                let playerVC = PlayerViewController()
                
                // Передаем данные через делегат
                delegate?.didSelectedSong(image: selectedTrack.image, track: selectedTrack.track, artist: selectedTrack.artist)
                
                // Добавляем выбранный трек в массив треков в PlayerViewController
                playerVC.tracks.append((image: selectedTrack.image, track: selectedTrack.track, artist: selectedTrack.artist))
                playerVC.currentTrackIndex = playerVC.tracks.count - 1
                playerVC.setupAudioPlayer()
                navigationController?.pushViewController(playerVC, animated: true)
                
                print("Track selected: \(selectedTrack.track)")
        }
    
    //height for row in section
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    //setup the footerView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = AppColors.lightGrayMain
        return footerView
    }
    
    //height for footer between cells
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
