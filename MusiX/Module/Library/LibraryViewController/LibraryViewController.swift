//
//  LibraryViewController.swift
//  MusiX
//
//  Created by Timofey on 14.07.24.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate {
    
    private lazy var libraryCell: [(image: UIImage?, title: String)] = [
         (UIImage(systemName: "sun.max"), String("Sun")),
         (UIImage(systemName: "moon.fill"), String("Moon")),
         (UIImage(systemName: "music.microphone"), String("Microphone")),
         (UIImage(systemName: "star.fill"), String("Star"))
    ]
    
    //setup LibraryLabel
    private lazy var libraryTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Library"
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //setup tableView
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(LibraryTableViewCell.self, forCellReuseIdentifier: LibraryTableViewCell.reuseId)
        table.backgroundColor = .clear
        table.delegate = self
        table.isScrollEnabled = true
        table.layer.cornerRadius = 20
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
        view.backgroundColor = .white
        setupConstraints()
    }
    
    //setupConstraints
    func setupConstraints() {
        view.addSubview(libraryTitle)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            //setup constraints for libraryTitle
            libraryTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            libraryTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            //setup constraints for tableView
            tableView.topAnchor.constraint(equalTo: libraryTitle.bottomAnchor, constant: 10),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            //playlists
        ])
    }
}

//MARK: -- UITableViewDataSource, UITableViewDelegate
extension LibraryViewController: UITableViewDataSource {
    
    //Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        libraryCell.count
    }
    
    //Количество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    //Ячейка в секции
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewCell.reuseId, for: indexPath) as! LibraryTableViewCell
        let item = libraryCell[indexPath.section]
        return cell
    }
    
    //Высота ячейки в секции
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    //Объявление отступа как отдельное view
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .black
        return footerView
    }
    
    //Высота отступа между секциями
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
}

#Preview { 
    TabBarViewController()
}
