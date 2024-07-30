//
//  LibraryViewController.swift
//  MusiX
//
//  Created by Timofey on 14.07.24.
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
         (UIImage(systemName: "music.note"), "Let It Happen" , "Time Impala")
         
    ]
    
    // setup titleTopView
    private lazy var topTitleView: UIView = {
        let topView = UIView()
        topView.backgroundColor = .clear
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    // setup LibraryLabel
    private lazy var libraryTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Library"
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
        topTitleView.addSubview(libraryTitle)
        NSLayoutConstraint.activate([
            
            // setup constraints for libraryTitle
            topTitleView.topAnchor.constraint(equalTo: view.topAnchor),
            topTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topTitleView.heightAnchor.constraint(equalToConstant: 100),
            
            // setup constraints for libraryTitle
            libraryTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            libraryTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            libraryTitle.heightAnchor.constraint(equalToConstant: 40),
            
            // setup constraints for tableView
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
            
            // playlists...
            
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
        delegate?.didSelectedSong(image: selectedTrack.image, track: selectedTrack.track, artist: selectedTrack.artist)
        
        print("select")
        }
    
    //height for row in section
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
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
