//
//  SettingsViewController.swift
//  MusiX
//
//  Created by Tim Zykov on 14.07.24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var tapGesture: UITapGestureRecognizer?

    
    private lazy var settingsCell: [(image: UIImage?, title: String)] = [
        (UIImage(systemName: "globe"), String("Language")),
        (UIImage(systemName: "arrow.down.circle"), String("Downloaded music")),
        (UIImage(systemName: "circle.lefthalf.filled.inverse"), String("Theme")),
        (UIImage(systemName: "eye.circle"), String("About"))
    ]
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseId)
        table.layer.cornerRadius = 20
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.isScrollEnabled = false
        return table
    }()
    
    private lazy var donationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var donationLabel: UILabel = {
        let label = UILabel()
        label.text = "Support developer with a cup of coffee"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var donationImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icon-coffee-cup")
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .systemGray6
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 20
        return img
    }()
    
    private lazy var donationStackView: UIStackView = {
        let vstack = UIStackView()
        vstack.axis = .horizontal
        vstack.spacing = 15
        vstack.translatesAutoresizingMaskIntoConstraints = false
        return vstack
    }()
    
    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "made by Tim Zykov"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: -- Setup Layer
private extension SettingsViewController {
    
    func setup() {
        setupConstraints()
        view.backgroundColor = AppColors.lightGrayMain
    }
    
    
    func setupConstraints() {
        
        view.addSubview(aboutLabel)
        view.addSubview(tableView)
        view.addSubview(donationView)
        
        donationView.addSubview(donationStackView)
        donationStackView.addArrangedSubview(donationLabel)
        donationStackView.addArrangedSubview(donationImageView)
        
        NSLayoutConstraint.activate([
            
            aboutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboutLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            donationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            donationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            donationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            donationView.heightAnchor.constraint(equalToConstant: 150),
            
            tableView.topAnchor.constraint(equalTo: donationView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.heightAnchor.constraint(equalToConstant: 320),
            
            donationStackView.topAnchor.constraint(equalTo: donationView.topAnchor, constant: 20),
            donationStackView.leadingAnchor.constraint(equalTo: donationView.leadingAnchor, constant: 20),
            donationStackView.trailingAnchor.constraint(equalTo: donationView.trailingAnchor, constant: -20),
            donationStackView.bottomAnchor.constraint(equalTo: donationView.bottomAnchor, constant: -20),
            donationStackView.heightAnchor.constraint(equalToConstant: 100),
            donationStackView.widthAnchor.constraint(equalToConstant: 120),
            
            donationImageView.heightAnchor.constraint(equalToConstant: 5),
            donationImageView.widthAnchor.constraint(equalToConstant: 110)
            
        ])
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        settingsCell.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseId, for: indexPath) as! SettingsTableViewCell
        let item = settingsCell[indexPath.section]
        
        //rounded edges
        if indexPath.section == 3 ? true: false {
            let cornerRadius: CGFloat = 20.0
            let maskPath = UIBezierPath(roundedRect: cell.bounds,
                                        byRoundingCorners: [.bottomLeft, .bottomRight],
                                        cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            cell.layer.mask = maskLayer
        }
        
        cell.configure(contact: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
}

#Preview {TabBarViewController()}
